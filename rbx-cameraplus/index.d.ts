declare interface Easers {
	Linear(t: number, b: number, c: number, d: number): number;
	Standard(t: number, b: number, c: number, d: number): number;
	Deceleration(t: number, b: number, c: number, d: number): number;
	Acceleration(t: number, b: number, c: number, d: number): number;
	Sharp(t: number, b: number, c: number, d: number): number;
	Smooth(t: number, b: number, c: number, d: number): number;
	Smoother(t: number, b: number, c: number, d: number): number;
	RevBack(t: number, b: number, c: number, d: number): number;
	RidiculousWiggle(t: number, b: number, c: number, d: number): number;
	Spring(t: number, b: number, c: number, d: number): number;
	SoftSpring(t: number, b: number, c: number, d: number): number;
	Quad(t: number, b: number, c: number, d: number): number;
	Cubic(t: number, b: number, c: number, d: number): number;
	Quart(t: number, b: number, c: number, d: number): number;
	Quint(t: number, b: number, c: number, d: number): number;
	Sin(t: number, b: number, c: number, d: number): number;
	Expo(t: number, b: number, c: number, d: number): number;
	Circ(t: number, b: number, c: number, d: number): number;
	Elastic(t: number, b: number, c: number, d: number, a: number, p: number): number;
	Back(t: number, b: number, c: number, d: number, s?: number): number;
	Bounce(t: number, b: number, c: number, d: number): number;
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

	IsA(ClassName: string): boolean;
	SetPosition(Position: Vector3): void;
	GetPosition(): Vector3;
	SetFocus(Focus: Vector3): void;
	SetView(Position: Vector3, Focus: Vector3): void;
	SetFOV(FieldOfView: number): void;
	GetFOV(): number;
	IncrementFOV(Delta: number): void;
	SetRoll(Roll: number): void;
	GetRoll(): number;
	IncrementRoll(Delta: number): void;

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

	Tween(StartCFrame: CFrame, EndCFrame: CFrame, Duration: number, EasingFunction: Function): void;
	TweenTo(EndCFrame: CFrame, Duration: number, EasingFunction: Function): void;
	TweenToPlayer(Duration: number, EasingFunction: Function): void;
	TweenFOV(StartFOV: number, EndFOV: number, Duration: number, EasingFunction: Function): void;
	TweenToFOV(EndFOV: number, Duration: number, EasingFunction: Function): void;
	TweenRoll(StartRoll: number, EndRoll: number, Duration: number, EasingFunction: Function): void;
	TweenToRoll(EndRoll: number, Duration: number, EasingFunction: Function): void;
	TweenAll(StartCFrame: CFrame, EndCFrame: CFrame, StartFOV: number, EndFOV: number, StartRoll: number, EndRoll: number, Duration: number, EasingFunction: Function): void;
	TweenToAll(EndCFrame: CFrame, EndFOV: number, EndRoll: number, Duration: number, EasingFunction: Function): void;
	Interpolate(EndPosition: Vector3, EndFocus: Vector3, Duration: number, EasingFunction: Function): void;
}

declare const CameraPlus: CameraPlus;
export = CameraPlus;
