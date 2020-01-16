Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0120813FB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 22:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbgAPVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 16:11:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33553 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgAPVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:11:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so10534665pgk.0;
        Thu, 16 Jan 2020 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5VtMJf5ESlmUf37B+sO2UT8B6InyhdtiTRjc1HCzvY8=;
        b=M6fWj/e6pK2KCioLxIgvOTT9DkBbqVi4gnTk/PD9+RVhsSiRpAMNB0sm3NrtgNIARp
         N2XPqGupz5TwIEt9x9wHAymiGtzNpGyE8OGrVhrW+gd43X6bM5OEaeSmFRcpIZtethnT
         N2FJYxFlBVOsBKh25v9irAmOJ3QX+/oe7b64KqnaSWjRN+x9YOpO7dC79VOwpXhAwU0B
         5vHZyDtS+qcNmVFVFU1vKWtrd+LdrjV/T4KXENTNa4G4icIwYB/k1bp8PSR1xdWTMeSi
         5+RvCAlVxSEvMYqHmm93ZJ/8l83kQix4bZB7DZtm921j4CUEOlz3PcrEbfTWiEWE67zm
         DjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5VtMJf5ESlmUf37B+sO2UT8B6InyhdtiTRjc1HCzvY8=;
        b=cwxoHFfsKoqZY6UH+QglkS0FLyjWCUfXTclF9jjRXQNgM+YYGSKnL9JR3cbTf3ouit
         2DNcVamd2X1R46HIHKS3vMHDDN/sHBtum2yIG/HWOvcCkTn4Ukn4ynl+w6UMO776s65t
         x6GdKXEAjvtkkXfmK6D6dP++3t6cuwqcp9l6JwNovvXuDoljHVZPUYc/Nm0McGpeErpa
         UhLrN2/250nC7RLxT2VIy8QHBnqoFBA/XUnXQsRhTb4FHv+cPjOwcYVBosYJy/Qey+HO
         cVEWBdJgIOfkCP+Gb972lD7OResXj372XFoxsYtqqbbaM2ukshW5OECaeNV0CcSTocIy
         w6+w==
X-Gm-Message-State: APjAAAV5K4/5p761xqJhfvymG9f2J1sDc8K0t43VI/NBpip80gPJrXVz
        9nxZwLcjr3ZN9JxnzRfNoes=
X-Google-Smtp-Source: APXvYqy/b3Y08fOd8BibfZacDSCiDbhzVpj4r+7laXLFSgLb3gxmDkcdki+K9neRlezST8hcwH9f8A==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr42997908pgg.239.1579209073573;
        Thu, 16 Jan 2020 13:11:13 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 100sm4665014pjo.17.2020.01.16.13.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 13:11:12 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:11:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Darren Salt <devspam@moreofthesa.me.uk>
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
Message-ID: <20200116211111.GA32333@roeck-us.net>
References: <20200116141800.9828-1-linux@roeck-us.net>
 <5838D7FEC0%devspam@moreofthesa.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5838D7FEC0%devspam@moreofthesa.me.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 08:55:16PM +0000, Darren Salt wrote:
> Tested-By: Darren Salt <devspam@moreofthesa.me.uk>
> 
Thanks!

Guenter

> Linux 5.4.12, Ryzen 5 1600. Patches were applied cleanly. No problems noticed in
> 
>     $ sensors k10temp-pci-00c3
>     k10temp-pci-00c3
>     Adapter: PCI adapter
>     Vcore:	  +1.11 V
>     Vsoc:	  +0.94 V
>     Tdie:	  +42.8°C  (high = +70.0°C)
>     Tctl:         +42.8°C
>     Icore:       +15.59 A
>     Isoc:    	 +12.63 A
>     
>     $
> 
> -- 
> |  _  | Darren Salt, using Debian GNU/Linux (and Android)
> | ( ) |
> |  X  | ASCII Ribbon campaign against HTML e-mail
> | / \ |
