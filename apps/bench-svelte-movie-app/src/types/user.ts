export type User = {
  id: number;
  name: string;
  username: string;
  avatar: {
    tmdb: {
      avatar_path: string;
    };
  };
};
