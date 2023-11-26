declare type ForEveryPlayerCallback = (player: Player) => unknown;

declare function ForEveryPlayer(
	addedCallback?: ForEveryPlayerCallback,
	removingCallback?: ForEveryPlayerCallback,
): () => void;

export = ForEveryPlayer;
