Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1ECC7A4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 06:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfJEEMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 00:12:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJEEML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:12:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id q7so4838718pgi.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tDHZY7i0iziEELzVvxjqEm4cMO1oJyX/TqJTG8MncDg=;
        b=UPKPu6nDI5XZ9uTUtEwlP++RWapEu7sLryWy6tCdsxYHzissWIHoJvw7OunllnzsI0
         Fes1SNsHRK6F9GjLIpw4lLQ+VViQOfjSP9+TFRXVEalhCzESQzgWXOH+RhP6TMQsYa33
         DMZw6lwW6+r808ZXFPTdxFryomDOgv7XXRizBZ4h+kNoUM0JMfNkAeJ2JvKKs21sqCZU
         ZJTfJtafPPkhdGM9AQegnQic+jFTqOHg30eUlNOyJuzEbLZymKwi4xDz3GqKmIeD4vbQ
         U7hwDsxMDCp87jm1JNJ45UbYMJiaoACncCOriJh7PrThULEdhtneq3UmWJNowvu8N6KU
         8Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tDHZY7i0iziEELzVvxjqEm4cMO1oJyX/TqJTG8MncDg=;
        b=W+pMV+QBGvKYSbVTV08f/jf7xsgJ0KKGRKh0dW3vwDThAn32dIWlmsUwwFX48qsz6n
         YvOm+YSAHqujQCUEXy9wa3XhciDyWHoI7CyEPLGOU6sdjAR6OjYIsaRK/x0NtqhbbKy/
         ZssNyB+TxrOBPoCmKn3ltIe9pjTc727r93ZhNwJsc1sLDL6gmQqws/+MboTnem6zQfcG
         cCKfuz+p24zAmMrqsGDmOx25J9BgCj1Fxp310CKBSyQHUX+PI8kPBpzrk67ByUAR/3xC
         qqzjzID3hl5fAZpgm14x9UhwMEQejMWRKQDx/VzV/Ao8YiVnpD19iXvTurQADLfoY/cd
         h8fQ==
X-Gm-Message-State: APjAAAVfyBk5RQVNNJKTQAY0I5wKhDlCHOzEtG9lVOr7NvDtO+Vh9Gsq
        bNR6qFjMWAq5DCJQ64kEtU3+yA==
X-Google-Smtp-Source: APXvYqwDeF6E+Fovx/kwk+nnBJeWviqZdubVrtEeOznS/FjWQiJA1r0rVtuOGIKn7exk+jjcR7Glhg==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr20517130pfn.1.1570248731163;
        Fri, 04 Oct 2019 21:12:11 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e10sm9645914pfh.77.2019.10.04.21.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 21:12:10 -0700 (PDT)
Date:   Fri, 4 Oct 2019 21:12:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: debug: Remove unneeded NULL check
Message-ID: <20191005041208.GE5189@tuxbook-pro>
References: <1569293934-31451-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569293934-31451-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Sep 19:58 PDT 2019, Ding Xiang wrote:

> debugfs_remove_recursive will do NULL check, so remove
> the redundant null check
> 

Nice, applied.

Regards,
Bjorn

> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 8cd4a0a..dd93cf0 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -333,9 +333,6 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  
>  void rproc_delete_debug_dir(struct rproc *rproc)
>  {
> -	if (!rproc->dbg_dir)
> -		return;
> -
>  	debugfs_remove_recursive(rproc->dbg_dir);
>  }
>  
> -- 
> 1.9.1
> 
> 
> 
