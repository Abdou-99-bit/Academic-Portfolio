
// interface Props {
//   src: string;
//   alt: string;
//   className?: string;
// }

// export const ProductImage = ({ src, alt, className }: Props) => {
//   if (!src) return <div className={className}>No Image</div>;

//   return <img src={src} alt={alt} className={className} />;
// }




// interface Props {
//   src: string;
//   alt: string;
//   className?: string;
// }

// export const ProductImage = ({
//   src,
//   alt,
//   className
// }: Props) => {

//   // ✅ HANDLE MYSQL IMAGE PATHS
//   const fullPath =
//     src.startsWith("http")
//       ? src
//       : `http://localhost:5000/images/${src}`;

//   return (
//     <img
//       src={fullPath}
//       alt={alt}
//       className={className}
//     />
//   );
// };


interface Props {
  src: string;
  alt: string;
  className?: string;
}

export const ProductImage = ({
  src,
  alt,
  className
}: Props) => {

  let fullPath = "";

  // ✅ CASE 1: full URL already exists
  if (src.startsWith("http")) {
    fullPath = src;
  }

  // ✅ CASE 2: starts with /images
  else if (src.startsWith("/images")) {
    fullPath = `http://localhost:8000${src}`;
  }

  // ✅ CASE 3: plain filename
  else {
    fullPath = `http://localhost:8000/images/${src}`;
  }

  return (
    <img
      src={fullPath}
      alt={alt}
      className={className}
    />
  );
};