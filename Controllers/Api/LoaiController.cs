
using System.Linq;
using System.Net;
using System.Web.Http;
using WebsiteQLBanDongHo.WebsiteQLBanDongHoDomain.DataContext;

namespace WebsiteQLBanDongHo.Controllers.Api
{
    [RoutePrefix("api/loai")]
    public class LoaiController : ApiController
    {
        private readonly WebsiteQLBanDongHoEntities db = new WebsiteQLBanDongHoEntities();

        // GET: /api/loai
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetAll()
        {
            var data = db.LOAISANPHAMs
                .Select(x => new { x.MALOAISP, x.TENLOAISP })
                .ToList();

            return Ok(data);
        }

        public class LoaiUpsertDto
        {
            public string TENLOAISP { get; set; }
        }

        // POST: /api/loai
        [HttpPost]
        [Route("")]
        public IHttpActionResult Create([FromBody] LoaiUpsertDto dto)
        {
            if (dto == null || string.IsNullOrWhiteSpace(dto.TENLOAISP))
                return BadRequest("Tên loại không được rỗng");

            var entity = new LOAISANPHAM
            {
                TENLOAISP = dto.TENLOAISP.Trim()
            };

            db.LOAISANPHAMs.Add(entity);
            db.SaveChanges();

            return Content(HttpStatusCode.Created, new { entity.MALOAISP, entity.TENLOAISP });
        }

        // PUT: /api/loai/5
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult Update(int id, [FromBody] LoaiUpsertDto dto)
        {
            if (dto == null || string.IsNullOrWhiteSpace(dto.TENLOAISP))
                return BadRequest("Tên loại không được rỗng");

            var entity = db.LOAISANPHAMs.FirstOrDefault(x => x.MALOAISP == id);
            if (entity == null) return NotFound();

            entity.TENLOAISP = dto.TENLOAISP.Trim();
            db.SaveChanges();

            return Ok(new { entity.MALOAISP, entity.TENLOAISP });
        }

        // DELETE: /api/loai/5
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            var entity = db.LOAISANPHAMs.FirstOrDefault(x => x.MALOAISP == id);
            if (entity == null) return NotFound();

            db.LOAISANPHAMs.Remove(entity);
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) db.Dispose();
            base.Dispose(disposing);
        }
    }
}
