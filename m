Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4572AE0A08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfJVRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 13:04:03 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com ([77.238.179.83]:35437
        "EHLO sonic309-25.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730727AbfJVRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1571763839; bh=VuQW1HiPC+eEHoR1PotD3z/iRiOV1eI7zvzLjw5e0oo=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=UAfqtuBLLNotTv75UbTcW17hvLqCBIrLvGO/j4BdFj8Kf0EI8w5NR8luWJINQiLoEycz0EEbRvPPGZXt5c/nsjKxG9XEbFgDBxNMXzpwRIpMjw2QirwlWe3qCbIBNFWIvA5GnQZIkdyCfA2ekaVPdJtV+ckF8xtWkG7qPLNPHrcguE27pQmqI65TzkSfQv2tgO62MtcEMQCjIfAXPwAvEVityAbUlp3JwIptWxwUVbbMvwqUWVRh2HEffOZV27t0HCdO/jJIxTe50O+QWQBLxNeBHoQWk39qNLSFKcjpeNr1Ez5JeR0wr00Ii02c/V1SwEhuAUZEVTyoIy9EzvBNwg==
X-YMail-OSG: tuU6hvkVM1nu8.T513hv1Ex8aMA3jddzjMb1NjjSKefhS6opMdjYX34r0DHXqlT
 jTJhd_YJKxuPr4S2FOewJVNjNXLZ1iGT6TGERwVP9FpT5I50glbK1W.MiMcPxDgqtQIRBIUEGDkh
 NZPqoDokoSTUf29nH7B.3UI67aWDhcITq937CI4Auq3O8epozqH.uL1nGuFYpKoyGCa82l_XU_J8
 waNMVWjvnFGGx7ibb7Pcx7OYqI26IlTSqkxaSxiOmuHvUy7e8DghB7fOEcgsWD9q9GIhz1DBozr1
 ZYojYOJvmA4QFpY9cfF_A6iVvQDx2ZlqvARE9_PZ3PncmauYnIgnf0a21OcnSmXhJXG1J_Nn0VXR
 OWeICS9lOlL7yDmZWhuZhp1j9DPXUIf156EgBFVZUnMXGPd0322bevT1eECLWvo6ufJbM7g3DhKi
 Ok8pjSXDnzAVxdLmQwtLLMsLvenn8bD.OjUNntpCW0BSQV7JCqKJp4ZNREP7cGBzEUm4foaCLTZJ
 HreIXy6D9Ax8l3.jBV4j74Dwm2EEeFHeLmVHEJFWMvsCQUWrrCYsZQgzyQLSowUGZP0yF_iNiDRM
 .JUzTU6UJMAUzRwhBu9A6AfN97kwRt2CQCMvcKKzKoUZ_Nd9LVYQgwiC67wLvuxniXzLGcXi30ml
 QUpSeAc_PNJy62YSIDECWJK23xeC6Sun4voy803BqnQw_7U1Uh4crdO4EjaEWpdXLRrR_2VpXUNm
 RDnky_XWw1hfq2adegvQVgZBkCciJCPu0C6EFt0rC4Xo6s30yufmTTbcIyz3bw6mKBbWG75JE9Sz
 IZwEoy0GemvQMj9RHj4zpCdjsPADonRpR1B1Eohzc0I51TcWxxUXWdONc1Veom19GZVW2pYYHEmI
 Zkz82HYPB3iZeoE4exTLwydAm_VvBROnvulwv6Eta4hWIkkakRsXa69b3bmdrRWO2Q6tnyJqsn6r
 qEZF9Rl_PEPmrB9s0zMcrMCrttnOfRYsBivRTB1i.tL.pHvW1IBf04BeOXGrkGjSDyx6gl610ZMi
 4_0YVTcgcUk3NTbuTtQY5llzn2t_8J.z3bz.FSH10lM62Zod7Z2b2WT0yx8W4vZumOKlc7x6C2Jc
 dcABN0X8y1a9EKxUiJ0lOE8BbwU97tvmxY6hHms69TNdsHubACzXzYN_xGxQVTeK0lKtzNf8ng.e
 MXEf_4wP657bNedaychGOnbEbksH7cT0VDJXOcGuiM8APR1ZKWSh_COHGnHUSTg9TfFxR6ZrheZy
 E9XNcbxBSUx46UcBE.Wb02Pjk2RtCI5nOW9aJhao1ncCivVvOE43Ofp.06goJXBYhEzufCqxAOG_
 TELALH_hc6TKhZjfbbgoEI6zCDvaXuJnreQgyJEViWpLh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Tue, 22 Oct 2019 17:03:59 +0000
Received: by smtp428.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 13c3d1b14e4a7c78846e956c04b720a5;
          Tue, 22 Oct 2019 17:03:54 +0000 (UTC)
Date:   Wed, 23 Oct 2019 01:03:47 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Pratik Shinde <pratikshinde320@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Gao Xiang <gaoxiang25@huawei.com>,
        yuchao0@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-v2] erofs: code for verifying superblock checksum of an
 erofs image.
Message-ID: <20191022170340.GA4641@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191022153956.16867-1-pratikshinde320@gmail.com>
 <20191022163403.GA3201@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRBfVa+1WPCBYP2JAYRhRBXkn20-YmVw9J3XUbCxw0cNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czRBfVa+1WPCBYP2JAYRhRBXkn20-YmVw9J3XUbCxw0cNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:18:23PM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> Understood your concern.
> 
> Can we do something like :
> 
> 1) Allocate one buf of size EROFS_BLKSIZ
> 2) Read one page at a time into buf(memcpy) .call crc32c for it.
> 
> In this way we won't be writing directly into page data and will not do
> large allocation.
> What do you think?

Yes, that is the right way, but the buf is only be used to calc
the 0th block (super_block), for the rest blocks, no need to do this.

buf = kmalloc(EROFS_BLKSIZ);
memcpy(buf, data);
dsb->checksum = 0;
crc = crc32c(0, buf);
kfree(buf);

for (i = 1; i < nblocks; ++i) {
   page = get_meta_page(sb, i);

   data = kmap_atomic(page);
   crc = crc32c(crc, data);
   kunmap_atomic(data);
   unlock_page(page);
   put_page(page);
}
...

Or some better approach, but it's not ok to modify page cache directly.

Thanks,
Gao Xiang

> 
> --Pratik
> 
> On Tue, 22 Oct, 2019, 10:04 PM Gao Xiang, <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > Some comments as below...
> >
> > On Tue, Oct 22, 2019 at 09:09:56PM +0530, Pratik Shinde wrote:
> > > Patch for kernel side changes of checksum feature.Used kernel's
> > > crc32c library for calculating the checksum.
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > ---
> > >  fs/erofs/erofs_fs.h |  5 +++--
> > >  fs/erofs/internal.h |  3 ++-
> > >  fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 38 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > > index b1ee565..4d8097a 100644
> > > --- a/fs/erofs/erofs_fs.h
> > > +++ b/fs/erofs/erofs_fs.h
> > > @@ -17,6 +17,7 @@
> > >   */
> > >  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING  0x00000001
> > >  #define EROFS_ALL_FEATURE_INCOMPAT
> >  EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> > > +#define EROFS_FEATURE_COMPAT_SB_CHKSUM               0x00000001
> > >
> > >  /* 128-byte erofs on-disk super block */
> > >  struct erofs_super_block {
> > > @@ -37,8 +38,8 @@ struct erofs_super_block {
> > >       __u8 uuid[16];          /* 128-bit uuid for volume */
> > >       __u8 volume_name[16];   /* volume name */
> > >       __le32 feature_incompat;
> > > -
> > > -     __u8 reserved2[44];
> > > +     __le32 chksum_blocks;   /* number of blocks used for checksum */
> > > +     __u8 reserved2[40];
> > >  };
> > >
> > >  /*
> > > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > index 544a453..cec27ca 100644
> > > --- a/fs/erofs/internal.h
> > > +++ b/fs/erofs/internal.h
> > > @@ -86,7 +86,7 @@ struct erofs_sb_info {
> > >       u8 uuid[16];                    /* 128-bit uuid for volume */
> > >       u8 volume_name[16];             /* volume name */
> > >       u32 feature_incompat;
> > > -
> > > +     u32 feature_compat;
> > >       unsigned int mount_opt;
> > >  };
> > >
> > > @@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void)
> > {}
> > >  #endif       /* !CONFIG_EROFS_FS_ZIP */
> > >
> > >  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> > > +#define EFSBADCRC    EBADMSG         /* Bad crc found */
> > >
> > >  #endif       /* __EROFS_INTERNAL_H */
> > >
> > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > index 0e36949..9cda72d 100644
> > > --- a/fs/erofs/super.c
> > > +++ b/fs/erofs/super.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/statfs.h>
> > >  #include <linux/parser.h>
> > >  #include <linux/seq_file.h>
> > > +#include <linux/crc32c.h>
> > >  #include "xattr.h"
> > >
> > >  #define CREATE_TRACE_POINTS
> > > @@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char
> > *function,
> > >       va_end(args);
> > >  }
> > >
> > > +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
> > > +                                    struct super_block *sb)
> > > +{
> > > +     u32 disk_chksum, nblocks, crc = 0;
> > > +     void *kaddr;
> > > +     struct page *page;
> > > +     int i;
> > > +
> > > +     disk_chksum = le32_to_cpu(dsb->checksum);
> > > +     nblocks = le32_to_cpu(dsb->chksum_blocks);
> >
> > We cannot write the page data directly since the page cache should be kept
> > in
> > sync with ondisk data (or for read-write fs, if it's claimed as uptodated,
> > and
> > it is modified later,  you should mark it dirty, and do writeback then, but
> > that is not the erofs case.)
> >
> > > +     dsb->checksum = 0;
> > > +     for (i = 0; i < nblocks; i++) {
> > > +             page = erofs_get_meta_page(sb, i);
> > > +             if (IS_ERR(page))
> > > +                     return PTR_ERR(page);
> > > +             kaddr = kmap(page);
> >
> > Here kmap_atomic(page) is better. what I mean is kmap_atomic() in the
> > caller
> > erofs_read_superblock(), it should be replaced to kmap() instead.
> >
> > > +             crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
> > > +             kunmap(page);
> > > +             unlock_page(page);
> >
> > need
> >                 put_page(page);
> >
> >
> > I'm not sure whether I explained quite well, but this patch needs something
> > to do. I'm now working on demonstrating new XZ algorithm and releasing
> > erofs-utils v1.0.
> >
> > You can give more tries or I will help later. :-)
> >
> > Thanks,
> > Gao Xiang
> >
> >
> > > +     }
> > > +     if (crc != disk_chksum)
> > > +             return -EFSBADCRC;
> > > +     return 0;
> > > +}
> > > +
> > >  static void erofs_inode_init_once(void *ptr)
> > >  {
> > >       struct erofs_inode *vi = ptr;
> > > @@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_block
> > *sb)
> > >               goto out;
> > >       }
> > >
> > > +     if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
> > > +             ret = erofs_validate_sb_chksum(dsb, sb);
> > > +             if (ret < 0) {
> > > +                     erofs_err(sb, "super block checksum incorrect");
> > > +                     goto out;
> > > +             }
> > > +     }
> > >       blkszbits = dsb->blkszbits;
> > >       /* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
> > >       if (blkszbits != LOG_BLOCK_SIZE) {
> > > --
> > > 2.9.3
> > >
> >
