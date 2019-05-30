Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03852F998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfE3Jjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 05:39:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43766 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfE3Jjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:39:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so2320472plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HcywUzafthk86hjeemS/uZ4aa4I/rB7ZSDQIqK7Pq20=;
        b=c3Bb8oqw0+cZD/QgsmjCpekCRp/AVMOGqdApc4y9rNsgMnTcXMgz8tnBf3/+Cj7k6T
         NIdNUTXwVKHigk5KtI0yg1j/9nuGiqfpNEDrZgTwdYLjNib0JOv/VNzalmvZhTogwQty
         HtEYGpvaxGab60FTfcg+WTCzHSQbQPulUFyigo3P4R02UVIPIxXfTanPHDfFjQfFsaXF
         Wdthl91xgfYRfyBkoi1ZGEvaeMZRrqxKAfGqtLaYBJcn/muKFm7XAQY6ABNxFkp+//fY
         QgurnwIZfWDUbW0kKlL4G1a6YHfnYc0TIkIsqaTjHpmUJ7FNZ9tDanezN+7UiXpFQSSX
         Dujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HcywUzafthk86hjeemS/uZ4aa4I/rB7ZSDQIqK7Pq20=;
        b=Xa+hshz5QHxs76axez8qRa0P5APCC1Ta4XxGvnoAS8cs70agMXJYImg9DwnuHPXxjE
         RsOLRCrNvIjur5m35rRwdQQ+0cBL7Xf/U5tLAnAVoHB1YGbcgKjAeY946k7MBG3uopbh
         BBTRwX+MQXxL2y4Va61Tpss/a0qc1ZIb+ihK4e/9hli8zXPn95sLuRLipuUuq868dlk/
         Zs+9+V719XkngOfstAkiXQo6hMfsPxFsRL9GpxQI08ccTy7+7nRGaT0CEB7ljZZLGBAi
         6LKbpT3pKj3Vh4ogzxfm/sDfXg2L9a8VAp7h9TCK3vb0iI0dlDOdD0pxCrZrmobsHDy5
         OtAw==
X-Gm-Message-State: APjAAAX044F03XeBEx7LehorE0sqTqCy88Tc/Rh/0AuiS+j5yJOB9iGH
        V4Gli/PlGYLn02Xdo1PFMTLa09xVH8g=
X-Google-Smtp-Source: APXvYqz9qTW7HFwtEurjsKXEDx7+8ZY33bTeGh+bBCrgvKckAvm7+DzV5Qrg9l6S2quYD0qlNxZh0w==
X-Received: by 2002:a17:902:868a:: with SMTP id g10mr2863971plo.205.1559209194197;
        Thu, 30 May 2019 02:39:54 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 4sm2605152pfj.111.2019.05.30.02.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:39:53 -0700 (PDT)
Date:   Thu, 30 May 2019 17:39:37 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     inaky.perez-gonzalez@intel.com
Cc:     linux-wimax@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] wimax: debug: fix a missing-check bug in d_parse_params()
Message-ID: <20190530093937.GA4457@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In d_parse_params(), 'params_orig' is allocated by kstrdup(). It returns
NULL when fails. So 'params_orig' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/include/linux/wimax/debug.h b/include/linux/wimax/debug.h
index aaf24ba..bacd6cb 100644
--- a/include/linux/wimax/debug.h
+++ b/include/linux/wimax/debug.h
@@ -496,6 +496,11 @@ void d_parse_params(struct d_level *d_level, size_t d_level_size,
 	if (_params == NULL)
 		return;
 	params_orig = kstrdup(_params, GFP_KERNEL);
+	if (!params_orig) {
+		printk(KERN_ERR "%s: can't duplicate string '%s'\n",
+		       tag, _params);
+		return;
+	}
 	params = params_orig;
 	while (1) {
 		token = strsep(&params, " ");
