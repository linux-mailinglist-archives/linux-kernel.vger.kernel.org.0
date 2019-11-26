Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DDA10A162
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 16:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfKZPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 10:46:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:64419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfKZPq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:46:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 07:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="217183719"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 26 Nov 2019 07:46:55 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 26 Nov 2019 17:46:54 +0200
Date:   Tue, 26 Nov 2019 17:46:54 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix use after free in typec_register_port()
Message-ID: <20191126154654.GA6428@kuha.fi.intel.com>
References: <20191126140452.14048-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126140452.14048-1-wenyang@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:04:52PM +0800, Wen Yang wrote:
> We can't use "port->sw" and/or "port->mux" after it has been freed.
> 
> Fixes: 23481121c81d ("usb: typec: class: Don't use port parent for getting mux handles")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/usb/typec/class.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 7ece6ca..91d6227 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1612,14 +1612,16 @@ struct typec_port *typec_register_port(struct device *parent,
>  
>  	port->sw = typec_switch_get(&port->dev);
>  	if (IS_ERR(port->sw)) {
> +		ret = PTR_ERR(port->sw);
>  		put_device(&port->dev);
> -		return ERR_CAST(port->sw);
> +		return ERR_PTR(ret);
>  	}
>  
>  	port->mux = typec_mux_get(&port->dev, NULL);
>  	if (IS_ERR(port->mux)) {
> +		ret = PTR_ERR(port->mux);
>  		put_device(&port->dev);
> -		return ERR_CAST(port->mux);
> +		return ERR_PTR(ret);
>  	}
>  
>  	ret = device_add(&port->dev);
> -- 
> 1.8.3.1

thanks,

-- 
heikki
