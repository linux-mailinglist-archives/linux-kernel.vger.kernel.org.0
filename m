Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8559CCFD61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfJHPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:16:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47048 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfJHPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:16:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id b8so4058768pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBPyM3fbQmTRXscejMZaaT3oltRHFHQ/AKn9AwmsNPM=;
        b=RDQDDpTGcJ+CU5oG20pFY3+f/912vgZHPuOBlJgUk1GvQDsUpfZWJBhtrPPKHGfKin
         c5AdPIUJyuSFtv4Ck3+oddWe8kHzE2HPZDNDS+7KJmU8uLuldtt7ZDdvCtovD0E8VbrN
         btPCwrL3cx9q+KOhIImmLCHtb+dFYgRngz/lyeNtpz0fdmTtEbdk7+Fz3SCLciVUP8iF
         FOMIIRUR+k/RWlUzyE/tzCGnpQtp9VJl/Vx/3M0b8oGasvTFtiehokX7qML5vIXF4rc5
         4aa50AzB2ptrVVEy6mvF0FrXSQg268RXPTed+3GNECqZM2flg+XDeq16K0Nqpm/XlsWf
         +KjA==
X-Gm-Message-State: APjAAAX0c8biphVW0Rpa9j8l9hLOVy4CF9wLPEdY5faNGKTGRdUzdxhd
        Sgx+OpiwKwkjVNPpXDxeu6lpbGmmIKg=
X-Google-Smtp-Source: APXvYqxL4tqZxI7W5Qba4JPc57Aq4UBeRh411inoIg4ZNNcMTEOzHxTu5bSzWPdCj/QC8rP4guJXAg==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr6336570pjn.10.1570547790809;
        Tue, 08 Oct 2019 08:16:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e21sm13287017pgk.57.2019.10.08.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:16:29 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D3FE140255; Tue,  8 Oct 2019 15:16:28 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:16:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191008151628.GA16384@42.do-not-panic.com>
References: <20191007184231.13256-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007184231.13256-1-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:42:31PM -0600, Tuowen Zhao wrote:
> +EXPORT_SYMBOL(devm_ioremap_uc);

EXPORT_SYMBOL_GPL() would be my preference.

 Luis
