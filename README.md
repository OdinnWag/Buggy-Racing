# MCT-F26 Project 1

MATLAB backend for the Webots tractor-racing controller project. The repository
contains a Webots R2025a world, a MATLAB controller template, the reference
trajectory, and the course grader. Python is not required.

## Platform support

| Platform | Webots package | Vehicle library |
| --- | --- | --- | 
| Windows 10/11 (64-bit) | R2025a `.exe` | `driver.dll` |
| macOS 14+ | R2025a `.dmg` | `libdriver.dylib` | 
| Ubuntu 22.04/24.04 (64-bit) | R2025a `.deb` or tarball | `libdriver.so` | 

The controller detects the operating system at runtime and selects the native
Webots vehicle library. macOS and Ubuntu support follows Webots' documented
library names and installation layout, but has not yet been exercised on those
operating systems. Do not use the Linux Snap package because its sandbox does
not support MATLAB controllers.

## Install the software

### 1. Install Webots R2025a

Download the R2025a installer for your operating system from the
[official Webots releases](https://github.com/cyberbotics/webots/releases/tag/R2025a),
then install the build for Windows, macOS, or Ubuntu Linux. On Windows, the
default location is `C:\Program Files\Webots`.

This project targets R2025a specifically. Opening and saving the world with an
older Webots release can rewrite it into an incompatible format.

### 2. Install MATLAB

Download and install a 64-bit MATLAB release through
[MathWorks Downloads](https://www.mathworks.com/downloads/). A valid MathWorks
account and MATLAB license are required. The project has been verified with
MATLAB R2025a.

Install a MATLAB-supported C compiler because the controller uses
`loadlibrary` to load Webots' native controller and vehicle-driver libraries:

- Windows: install the [MATLAB Support for MinGW-w64 C/C++ Compiler](https://www.mathworks.com/matlabcentral/fileexchange/52848-matlab-support-for-mingw-w64-c-c-compiler)
  add-on.
- macOS: install the Xcode Command Line Tools and select a supported Clang
  compiler in MATLAB.
- Linux: install a GCC version supported by the installed MATLAB release.

In MATLAB, run `mex -setup C` once and confirm that a compiler is selected.

Webots and MATLAB must use the same architecture; use 64-bit MATLAB with the
64-bit Webots installation.

### 3. Configure MATLAB in Webots

Webots normally detects the newest MATLAB installation automatically. If it
does not:

1. Open Webots.
2. Open **Tools > Preferences > General**.
3. Set the MATLAB command to the full MATLAB executable path.

On Windows, select the executable inside `bin\win64`, for example:

```text
C:\Program Files\MATLAB\R2025a\bin\win64\MATLAB.exe
```

Do not select `bin\MATLAB.exe`; Webots' R2025a documentation notes that this
launcher can interfere with controller output and process termination.

On macOS, select the MATLAB application if automatic detection fails. On Linux,
select the full path to the MATLAB executable, commonly
`/usr/local/MATLAB/R2025a/bin/matlab`.

The official references are the Webots
[installation guide](https://cyberbotics.com/doc/guide/installation-procedure)
and [MATLAB controller guide](https://cyberbotics.com/doc/guide/using-matlab).

## Clone and run

1. Clone or download this repository, preserving its folder structure.
2. Start Webots R2025a.
3. Select **File > Open World...**.
4. Open `worlds/automotive_new.wbt`.
5. Confirm that `DEF Tractor Robot` uses controller `main_matlab`.
6. Press **Run**.

Webots launches MATLAB automatically and runs
`controllers/main_matlab/main_matlab.m`. Do not start that file directly from
MATLAB: Webots must establish the controller connection and environment first.

The first launch can take longer because MATLAB generates platform-specific
interface files for the Webots libraries. Subsequent simulation output appears
in the Webots console. The controller selects `driver.dll` on Windows,
`libdriver.dylib` on macOS, and `libdriver.so` on Linux automatically.

For a new machine, verify that the Webots console prints
`MATLAB controller starting...` without a `loadlibrary` error. Then test the
normal edit cycle: stop or pause the simulation, save `your_controller.m`,
reset the world, and run again. Reset launches a new MATLAB controller process
and reloads the saved class. If the controller template is unchanged, the UI
will load but the tractor will remain stationary because both control outputs
are zero.

## Implement the assignment controller

Edit only:

```text
controllers/main_matlab/your_controller.m
```

The supplied file is the student template. Implement the two labeled sections:

- Lateral control: calculate and assign steering command `delta`.
- Longitudinal control: calculate and assign force command `F`.

The template initially assigns zero to both outputs, so the project can run
safely before an implementation is added. After editing it:

1. Save `your_controller.m`.
2. Reset the simulation in Webots.
3. Press **Run** again.

Do not rename the controller folder or `main_matlab.m`; Webots identifies a
MATLAB controller by matching its controller directory and entry-point name.

## Grading and output

After the tractor reaches the destination, the grader reports:

- loop-completion score;
- average-distance score;
- maximum-distance score;
- completion-time bonus; and
- total score out of 100.

MATLAB also creates `controllers/main_matlab/controller_results.png`. Generated
result images and simulation logs are ignored by Git.

## Important files

- `worlds/automotive_new.wbt` — Webots R2025a world.
- `protos/TractorFrontWheel.proto` — R2025a-compatible front-wheel geometry.
- `protos/TractorRearWheel.proto` — R2025a-compatible rear-wheel geometry.
- `controllers/main_matlab/main_matlab.m` — simulation loop and UI.
- `controllers/main_matlab/your_controller.m` — student-editable template.
- `controllers/main_matlab/BaseController.m` — sensor access and state estimate.
- `controllers/main_matlab/evaluation.m` — grading implementation.
- `controllers/main_matlab/buggyTrace.csv` — reference trajectory.

