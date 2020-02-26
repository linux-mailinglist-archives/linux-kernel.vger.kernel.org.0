Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1716F82B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 07:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBZGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 01:44:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44541 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgBZGol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:44:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so1487250wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 22:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+KPHLK60Od8Tz3at5CtY8IsfsFpWA/aEWA5NAOhb0WU=;
        b=Qj/tpUstLELK5vv6XqennEvqhI9Dn1aambXr8LWCAJ6RuIMxB4e0WMnhKK5YG/SBdd
         hByGxHZcQhTwcMBvErtFpZIRGnXN5cjYHubnkEswYSUXOcwaGjaKJyolTBbvUlUbxybe
         2/mjGV4Oc+ubFZ9mAfVT7rDyiWVJr3Db4gbr64XQc6JXYc9WBJK7L+FiGWITA6ZPIfaz
         KXCLkXdbt2luMqQsf7MjdoZqzFyrxj0RJ60O+aCRx5ACbZ997AYNKLJYFtSWoMyL8hzn
         yP6fjO2FqSLFJVwfqlO22iGfHrdfyfvq6IWt1Z7IVFMwUwStXWHe8flFmc80KUMBWT0C
         cDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+KPHLK60Od8Tz3at5CtY8IsfsFpWA/aEWA5NAOhb0WU=;
        b=UoupXOPzWVSOF8bZozEjRxgGqgwzoeMzdNjKoOfj2AR0fj2EPuvsN+GasOvOSTlp06
         awQFRFtM4IZTMCBfBbBGvKgiDU5BTc5Iv2XXvpwIUHX92cbGS1dn4YF5L6O+ET3LsKbE
         RAeUX2HU4FvaVdz0hlXTiCOF4TbeHUXExEmI7cULY08H1d7tSJQjbBsekF7oHgnT/Ncb
         G04M/aMA6+6H/tuhiErHzO3OqrL0SSHrEqUAENxTeAj8P9lLDPHwWSKpIcu/CFBgQnyy
         ryyHKKLLBwSpw6PZLm88Oho+e0giEuy7FM/C9P3amXlDmSfSY26el6zQNmYFCSrLUa8R
         ESyA==
X-Gm-Message-State: APjAAAXAoOScAyOgwPFAY9wOsv85YjqaWcVOUdCsI923JMWYrpvaj/ao
        GiCJymIekw+0/3pC1ZD7J30Y8Q==
X-Google-Smtp-Source: APXvYqzzKWMArtaFbi5nyEZ/y+P8oPK5jIkuzcSZocgxqUWUIHT0bV17ls7m2M7xepaDkZ5R4ou4BQ==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr3653907wrw.313.1582699479274;
        Tue, 25 Feb 2020 22:44:39 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id g25sm8002307wmh.3.2020.02.25.22.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 22:44:38 -0800 (PST)
Date:   Wed, 26 Feb 2020 06:45:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/19] mfd: intel_soc_pmic_mrfld: Convert to use new
 SCU IPC API
Message-ID: <20200226064510.GZ3494@dell>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-13-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200217131446.32818-13-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Mika Westerberg wrote:

> This converts the Intel Merrifield PMIC driver over the new SCU IPC API
> where the SCU IPC instance is passed to the functions.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_mrfld.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
