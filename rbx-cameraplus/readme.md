# rbx-cameraplus

### Getting Started

```TypeScript
import CameraPlus from "rbx-cameraplus";
```

----

### API Reference

>Inherited methods and properties

```TypeScript
import CameraPlus from "rbx-cameraplus";

CameraPlus.Name = "CustomCamera";
CameraPlus.setRoll(math.rad(45));
CameraPlus.FieldOfView = 35;
print(CameraPlus.isA("Camera")); // true
CameraPlus.CameraType = Enum.CameraType.Scriptable.Value;
```

>CameraPlus.Ease

This is a table containing all the easing functions you can use for interpolating the Camera.

It contains the tables:

* CameraPlus.Ease.I<span></span>n
* CameraPlus.Ease.Out
* CameraPlus.Ease.InOut
* CameraPlus.Ease.OutIn

All of those tables contain the functions:

* Linear
* Standard
* Sharp
* Acceleration
* Deceleration
* Smooth
* Smoother
* RevBack
* RidiculousWiggle
* Spring
* SoftSpring
* Quad
* Cubic
* Quart
* Quint
* Sine
* Expo
* Circ
* Elastic
* Back
* Bounce

An example of how to use Ease:

```TypeScript
const SineInOut = CameraPlus.Ease.InOut.Sine;
const CircOut = CameraPlus.Ease.Out.Circ;
const Smoother = CameraPlus.Ease.OutIn.Smoother; // This is one of the functions that's the same no matter if it's In, InOut, Out, or OutIn.
const ExpoIn = CameraPlus.Ease.In.Expo;
```

> *void* CameraPlus.setPosition(*Vector3* Position)

Set the position of the camera.

**Note:** The camera continues to look at the last position it was looking at.

Example:

```TypeScript
CameraPlus.setPosition(new Vector3(0, 10, 40));
CameraPlus.SetPosition(new Vector3(40, 10, 0));
```

> *Vector3* CameraPlus.getPosition()

Gets the position of the camera.

Example:

```TypeScript
const CurrentPosition = CameraPlus.getPosition() as Vector3;
const CurrentPosition = CameraPlus.GetPosition() as Vector3;
```

[Original documentation](http://sleitnick.github.io/CameraPlus/reference.html)
