Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D35410A17A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfKZPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 10:49:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:17992 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfKZPtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:49:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 07:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="217184051"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 26 Nov 2019 07:49:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 26 Nov 2019 17:49:13 +0200
Date:   Tue, 26 Nov 2019 17:49:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: roles: fix a potential use after free
Message-ID: <20191126154913.GB6428@kuha.fi.intel.com>
References: <20191124142236.25671-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191124142236.25671-1-wenyang@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 10:22:36PM +0800, Wen Yang wrote:
> Free the sw structure only after we are done using it.
> This patch just moves the put_device() down a bit to avoid the
> use after free.
> 
> Fixes: 5c54fcac9a9d ("usb: roles: Take care of driver module reference counting")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/usb/roles/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index 8273126..63a00ff 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -169,8 +169,8 @@ struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
>  void usb_role_switch_put(struct usb_role_switch *sw)
>  {
>  	if (!IS_ERR_OR_NULL(sw)) {
> -		put_device(&sw->dev);
>  		module_put(sw->dev.parent->driver->owner);
> +		put_device(&sw->dev);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_put);
> -- 
> 1.8.3.1

-- 
heikki
