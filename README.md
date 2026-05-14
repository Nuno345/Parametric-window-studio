<img width="1175" height="683" alt="Window Generator Image" src="https://github.com/user-attachments/assets/d5d0697e-4d23-404e-8b09-6fba2376eb86" />

A powerful, browser-based 3D generator for designing custom window frames, optimized for CAD workflows and 3D printing.

Parametric Window Studio allows you to instantly design, visualize, and export complex window geometries without needing a heavy desktop CAD program. Whether you are creating architectural models, designing props, or generating parts to send straight to your 3D printer, this tool provides real-time 3D rendering and instant STL exporting directly from your browser.

🌐 Try the Live Generator Here : https://nuno345.github.io/Parametric-window-studio/

🛠️ Local Usage
**Note:** To run this locally, you do not need to install Node.js or a build process.

1. Clone the repository or download the HTML file located in the releases section.  
2. Open the file directly in any modern web browser (Chrome, Edge, Firefox, Safari).  

**Note:** An active internet connection is required upon first load to fetch the Three.js library.

🚀 Features

The studio provides a comprehensive suite of parametric controls, organized into an intuitive UI with real-time feedback.

📐 Precision Controls
Dual-Input System: Fine-tune measurements using smooth sliders or exact numerical inputs.
Unit Support: Toggle seamlessly between Metric (mm) and Imperial (inches).
🏛️ Architectural Details
Arched Tops: One-click toggle to add an arch top, with adjustable radius parameters.
Integrated Sills: Generate complex window sills with independent controls for Y-drop, Z-depth extension, and X-side extension.
Exterior Trim: Add professional casing and trim with customizable overhang and thickness parameters.
🪟 Advanced Grid System
Muntin Configuration: Define custom muntin (grid bar) thickness.
Dynamic Grid Layouts: Set the exact number of columns and rows.
Proportional Panes: Alter the proportions of the top and bottom panes (e.g., creating a "Craftsman" style window with standard bottom panes and very short top panes).
💾 Export & Slicing
Live Slicer Stats: The UI calculates the absolute bounding box dimensions in real-time, so you know exactly how much build volume your window will consume.
One-Click STL Export: Instantly download an optimized, binary .stl file of your design, ready to be dropped into your slicer or CAD software.
🎨 Built-in Style Presets

If you need a starting point, the Studio includes routing presets that instantly reconfigure the engine:

Modern: Clean lines, deep frame, standard grid layout.
Gothic: Tall and narrow with a dramatic arched top and an extended sill.
Classic: Traditional thick exterior trim and standard proportions.
Minimalist: No trim, no sills—just the pure inner frame and grid.
🧩 OpenSCAD Version

Before the browser-based studio was developed, this project was originally created in OpenSCAD as a fully parametric script.

The OpenSCAD version remains available in the repository and can still be used for users who prefer script-based CAD workflows, direct code modification, or integration into existing OpenSCAD projects.

The browser version was developed afterward to provide:

A more intuitive visual interface
Real-time interactive editing
Faster design iteration
Immediate STL exporting without editing source code manually

While the HTML version offers a significantly improved UI and workflow, the original OpenSCAD source is preserved in the repository for reference, customization, and advanced manual editing.

💻 Technical Stack

This project runs entirely client-side. No server or backend is required to generate or export the models.

Engine: Three.js
 (WebGL 3D Rendering)
Structure: HTML5
Styling: Vanilla CSS (CSS Variables, Flexbox, CSS Grid)
Logic: Modern ES6 JavaScript Modules

⚠️ Known Issues
Depth Dimension Accuracy

The Depth slider is currently not dimensionally accurate.

At this time, adjusting the depth control may not produce a final exported model whose physical depth perfectly matches the entered slider value. This affects:

Live 3D preview depth scaling
Exported STL depth precision
Reported depth values during direct slider manipulation
Imperial Units Testing

Imperial mode (inches) has not been fully tested yet.

The unit toggle is implemented, but validation has primarily been performed in metric mode. Imperial conversions may require additional verification before production use.

Temporary Workaround

Until the depth calculation fix is implemented:

Use the “Total Slicer Size” section at the bottom of the interface as the authoritative measurement reference.

The Total Slicer Size readout reflects the actual generated model bounding dimensions and should be used to verify final print size before exporting.

Recommended Workflow
Adjust window parameters normally
Check the Total Slicer Size
Compare against your target printer build volume or project dimensions
Fine-tune depth based on the reported final bounding box rather than the slider value alone
Planned Fix

A future update will correct the depth calculation pipeline so that:

Slider values map directly to true model dimensions
Exported STL depth matches entered values exactly
Live preview, slicer dimensions, and export geometry remain fully synchronized
Imperial mode receives full validation and calibration testing

Developed by Nuno Lopez — original OpenSCAD engine and browser implementation. Assisted during development with ChatGPT by OpenAI
 for UI refinement, iteration, and documentation.
