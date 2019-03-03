declare enum Easers {
	Linear,
	Standard,
	Deceleration,
	Acceleration,
	Sharp,
	Smooth,
	Smoother,
	RevBack,
	RidiculousWiggle,
	Spring,
	SoftSpring,
	Quad,
	Cubic,
	Quart,
	Quint,
	Sine,
	Expo,
	Circ,
	Elastic,
	Back,
	Bounce
}

interface Ease {
	In: Easers;
	Out: Easers;
	InOut: Easers;
	OutIn: Easers;
}

interface CameraPlus {
	Ease: Ease;
	Name: string;
	CFrame: CFrame;
	CameraSubject: Instance;
	CameraType: Enum.CameraType;
	FieldOfView: number;
	Focus: CFrame;
	HeadLocked: boolean;
	HeadScale: number;
	Archivable: boolean;
	readonly NearPlaneZ: number;
	readonly ViewportSize: Vector2;

	isA(ClassName: string): boolean;
	setPosition(Position: Vector3): void;
	getPosition(): Vector3;
	setFocus(Focus: Vector3): void;
	setView(Position: Vector3, Focus: Vector3): void;
	setFOV(FieldOfView: number): void;
	getFOV(): number;
	incrementFOV(Delta: number): void;
	setRoll(Roll: number): void;
	getRoll(): number;
	incrementRoll(Delta: number): void;

	tween(StartCFrame: CFrame, EndCFrame: CFrame, Duration: number, EasingFunction: Function): void;
	tweenTo(EndCFrame: CFrame, Duration: number, EasingFunction: Function): void;
	tweenToPlayer(Duration: number, EasingFunction: Function): void;
	tweenFOV(StartFOV: number, EndFOV: number, Duration: number, EasingFunction: Function): void;
	tweenToFOV(EndFOV: number, Duration: number, EasingFunction: Function): void;
	tweenRoll(StartRoll: number, EndRoll: number, Duration: number, EasingFunction: Function): void;
	tweenToRoll(EndRoll: number, Duration: number, EasingFunction: Function): void;
	tweenAll(StartCFrame: CFrame, EndCFrame: CFrame, StartFOV: number, EndFOV: number, StartRoll: number, EndRoll: number, Duration: number, EasingFunction: Function): void;
	tweenToAll(EndCFrame: CFrame, EndFOV: number, EndRoll: number, Duration: number, EasingFunction: Function): void;
	interpolate(EndPosition: Vector3, EndFocus: Vector3, Duration: number, EasingFunction: Function): void;
}

declare const CameraPlus: CameraPlus;
export = CameraPlus;
