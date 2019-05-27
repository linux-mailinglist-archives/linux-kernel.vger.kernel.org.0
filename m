Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2712ADB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 06:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfE0Eem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 00:34:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41859 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfE0Eel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:34:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id d14so994802pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ck+F9ON2fnwh5hsuCM2qk61O5ay8betZRUcLdrsV0zI=;
        b=j+IVUH4GD9iVi5AQ0tl+V0V07fGHYVGHoxVefzWndaQjrffPAm/mM+Y1a4MoHG/U89
         p4QW6JgFkcgCvXvu44W+yz5LXEyov6GrVrVr2UVCx0STuRuG3ubwLcBI05O8KwYQQfLS
         qLZSfJ4qa29snAGa1sfVHjphAC1pcvgYZ2mSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ck+F9ON2fnwh5hsuCM2qk61O5ay8betZRUcLdrsV0zI=;
        b=DNs1Z2ROKh2zflcpr7rMAbEoOQyVYUNLPEe5R+k5Wdd7j98cf0cV7cAaTXDpys/Ahi
         r2DS8gze0l08i6jIw4jKgpi6ZzpN9iN4uQE1zeHxHA1KObm0NCodNM3JpVhMOo0dD1nh
         72cd39NSHOBLdHy3rFgiaFk+6YRyHHHSINXPYUNP+E1IhlMpW6uaGBWJtXeua05BXCN9
         Jwe8TWdAtmX04J5/Aytw6QtvvBVjC4xscVoUDESJeZEUFdlgpPrc6FF7V/TVUu7a/gPV
         ZIGZo6KEKnZgX9FYNN2/G736BXGj+PH5lSFLP1DbVmNYl+10uzq7pgKb3cI21XK02hLY
         Maww==
X-Gm-Message-State: APjAAAVeK3kQSJbIQ6oRmZq4M/jzf/tww7tSh3bXSxgOJ8jPyHHOluq6
        nlgHCIM+3fUmRmp6+3iIDxm+pQ==
X-Google-Smtp-Source: APXvYqyFrdw0mUt2bWg6+Evu1JeLd/Bd0yblbKAiu9bKbdKsHxgMYuF4cWcEbZG6DgbrO2oVmrykTQ==
X-Received: by 2002:a17:902:42d:: with SMTP id 42mr3916281ple.228.1558931681051;
        Sun, 26 May 2019 21:34:41 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id g9sm8236061pgs.78.2019.05.26.21.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 21:34:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v5 3/3] arm64: kexec_file: add rng-seed support
Date:   Mon, 27 May 2019 12:33:36 +0800
Message-Id: <20190527043336.112854-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527043336.112854-1-hsinyi@chromium.org>
References: <20190527043336.112854-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding "rng-seed" to dtb. It's fine to add this property if original
fdt doesn't contain it. Since original seed will be wiped after
read, so use a default size 128 bytes here.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..d40fde72a023 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -27,6 +27,8 @@
 #define FDT_PROP_INITRD_END	"linux,initrd-end"
 #define FDT_PROP_BOOTARGS	"bootargs"
 #define FDT_PROP_KASLR_SEED	"kaslr-seed"
+#define FDT_PROP_RNG_SEED	"rng-seed"
+#define RNG_SEED_SIZE		128
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
@@ -102,6 +104,23 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add rng-seed */
+	if (rng_is_initialized()) {
+		void *rng_seed = kmalloc(RNG_SEED_SIZE, GFP_ATOMIC);
+		get_random_bytes(rng_seed, RNG_SEED_SIZE);
+
+		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
+				RNG_SEED_SIZE);
+		kfree(rng_seed);
+
+		if (ret)
+			goto out;
+
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_RNG_SEED);
+	}
+
 out:
 	if (ret)
 		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
@@ -110,7 +129,8 @@ static int setup_dtb(struct kimage *image,
 }
 
 /*
- * More space needed so that we can add initrd, bootargs and kaslr-seed.
+ * More space needed so that we can add initrd, bootargs, kaslr-seed, and
+ * rng-seed.
  */
 #define DTB_EXTRA_SPACE 0x1000
 
-- 
2.20.1

