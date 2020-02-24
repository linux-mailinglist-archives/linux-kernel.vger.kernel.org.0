Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78F16AAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBXQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 11:10:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43759 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgBXQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:10:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so9140929oth.10;
        Mon, 24 Feb 2020 08:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geF43h/GISEHuxk4YneOEvQLm6Yk1MDXMbdkwrPL74Q=;
        b=f1euSri+HHKAD0orHNkh017haRYrUAouFY+z8uo2uZzBe6KhN+lZ1wGc/MPOOT3JAA
         ILPSPeT0x5+UnzeXLtQSbbRy1tF8NvKuYwxfdM+TmDvt1YMQ0ndp7RdggBnGKidXAocM
         VVGespAZlAadnlHk4bb89zoTLGr5ygBo1WYKB9z0lz61ItplX1OYMF5+lmk0CxtsLG1d
         6yFFsS4E8YNOzar6Qd9gmQDQBktaaBRkOLRi+pLMUeonljTW0q18j/ttcG+rKOFXS6Rc
         KzeIuf+Q3H/2s/q73AR29UuhK7DQ8V7YJZbW4YDLEZf7Y700aZvwiwRovEXXnzjO9Ei+
         uDTA==
X-Gm-Message-State: APjAAAXzYJ0GRz8gLhxicgf0MHEQnk5+ECMiEga42+RSpCs2QdB0eRem
        JxxBxG2jWM1FOrGW54NPsPwu/oyxbnv0yNrqG1M=
X-Google-Smtp-Source: APXvYqxwhV4YW1WGWTmeKg7V925d0UecVmBrPZaeuF7K3V9r8fExekSCvyGlSv08BqkBgdpJOZ8Hi4xtPCNP+H6Pmy4=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr39599169otl.189.1582560604001;
 Mon, 24 Feb 2020 08:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com> <20200224121406.2419-8-heikki.krogerus@linux.intel.com>
In-Reply-To: <20200224121406.2419-8-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Feb 2020 17:09:51 +0100
Message-ID: <CAJZ5v0gEHJNaMpx6Rc+DhdD3bg7xgxvDtXhq1X7p0QHEhmNvaA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] device property: Export fwnode_get_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:14 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This makes it possible to take advantage of the function in
> the device drivers.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 511f6d7acdfe..5f35c0ccf5e0 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -566,6 +566,7 @@ const char *fwnode_get_name(const struct fwnode_handle *fwnode)
>  {
>         return fwnode_call_ptr_op(fwnode, get_name);
>  }
> +EXPORT_SYMBOL_GPL(fwnode_get_name);

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
>  /**
>   * fwnode_get_name_prefix - Return the prefix of node for printing purposes
> --
> 2.25.0
>
