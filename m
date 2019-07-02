Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC725D987
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 02:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGCAqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 20:46:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42680 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:46:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so199802plb.9;
        Tue, 02 Jul 2019 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EEyrpPr6crLLek2K+2wB7hfBX7/xhxYts0mMWfA15n0=;
        b=BpurX42xyJabo6XzPspPcGbdnLp922qk/W7TJX65N+dSzI5mEFHNSiMrswD1+WZp8X
         qmv3hljs6PQg+GSAVPj657Xbo+wkPQcn3FAl5ALiYz254AGZTK8U8HTerDcv+0LL9oup
         seDSEJiX0hufrv5lN71zFgHk+OzOClqtbYxgunQTggn+Wbfrvf6E0TwSDg6juxYqB2tn
         DCptCNPyy6rnmaHD29kTULSJGZ0F75Q6AjC0Ucu4HsWgfFcmVAxxo5sBO6knS9rfSSeX
         JLI/0otsKYLrFAhKW0hjMaJ5I5/1xV8avpphCfFvyYHmJOcx7wu7+Vy+5uMdCEzNNgN8
         T3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEyrpPr6crLLek2K+2wB7hfBX7/xhxYts0mMWfA15n0=;
        b=Gj6b3m1mViioUAPh6vb44lkWE1EscMQzcsx80M7TFRiSULuA2ZUHZDuGsRZyS+D6r/
         743zP9lWEUH13WpczdRxNmGOCMxdw92GdJVtddR4T2rtdmC1yIzM6m8+uT7enTOqhFEA
         P/L2PHcEfFNFR+fKKWdvCWrXxYSXYoWMtI1OWnypgpo64/SQepwNk0yHGpB9zNmbpGPf
         wRLFI3FhuGcE+3Tsr1hk3Ldy9AKVQ7//muUsIw1hkVinurO5Ygntm8CCoMfD6L2SF+z1
         ktKk6V3B9w7Xrylo6NIpYh2HsbWoiobsB2A1cqZ8HNtQ06kDXXFmvSFr/6EEVm0/+YAc
         2plw==
X-Gm-Message-State: APjAAAVDGvNxSPL7lUYpL/VmPO5HX8FhsDUJG2YBxYSS5WD5wohKuzMw
        TYhgMHw4/g0nfdCcyImTZo8gguzvwcg=
X-Google-Smtp-Source: APXvYqwqXfwyfSKIUPGKCUBQYxQepOou1V+ytYU4yMV+xxkv1WLpxMrC8xgeoS1VfQyVa0jvP9K1Bg==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr18675828pls.267.1562108294798;
        Tue, 02 Jul 2019 15:58:14 -0700 (PDT)
Received: from continental ([189.58.144.164])
        by smtp.gmail.com with ESMTPSA id b24sm125821pfd.98.2019.07.02.15.58.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 15:58:13 -0700 (PDT)
Date:   Tue, 2 Jul 2019 19:58:57 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH v2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190702225857.GA19791@continental>
References: <20190618224454.16595-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618224454.16595-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Tue, Jun 18, 2019 at 07:44:54PM -0300, Marcos Paulo de Souza wrote:
> If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> 
>  Changes from v1:
>  changed the check of try_vpd_pages from:
>  	sdev->try_vpd_pages == 0;
>  to:
>  	!sdev->try_vpd_pages;
>  (as suggested by Alan Stern)
> 
>  drivers/usb/storage/scsiglue.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index 59190d88fa9f..30790240aec6 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -195,8 +195,11 @@ static int slave_configure(struct scsi_device *sdev)
>  		 */
>  		sdev->skip_ms_page_8 = 1;
>  
> -		/* Some devices don't handle VPD pages correctly */
> -		sdev->skip_vpd_pages = 1;
> +		/*
> +		 * Some devices don't handle VPD pages correctly, so skip vpd
> +		 * pages if not forced by SCSI layer.
> +		 */
> +		sdev->skip_vpd_pages = !sdev->try_vpd_pages;
>  
>  		/* Do not attempt to use REPORT SUPPORTED OPERATION CODES */
>  		sdev->no_report_opcodes = 1;
> -- 
> 2.21.0
> 
