Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15172D32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGXLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfGXLOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:14:49 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B80922ADC;
        Wed, 24 Jul 2019 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563966888;
        bh=QGWMl/ZXIY3EBLMtFI0LO4scm1QA+Ep6PNsO6TEPOnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qy2fqq3YJ0ckBc2x1bZmZCBCWFVM1L0iOXOd72aaiaV+I8MGIrh0AMROvbtDUEaGj
         VWn+C8ssNCFc0dLEI807dKPj/qrq36JLcbYScchmTXd861JWHW0Uhf7mvW/GFD3Wmy
         YrEkhvsApgpPuuE3PTOqvglCvrKM6v60+rwaVXAA=
Received: by mail-lf1-f41.google.com with SMTP id s19so31681933lfb.9;
        Wed, 24 Jul 2019 04:14:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWJ9x8liBl9LrwrTuAqWShEFSH+tDV+2dXqhHQsUhKW8G8rn94Y
        fIs61viD5GDS+Yr/Gx1n9T65Z7nRkznra3dUvkM=
X-Google-Smtp-Source: APXvYqyUmQ9tuUPElU/IV/IsqbXN/eGafRTyiXc6riwgNXXXlmd4X+4ShRqwKBSQLVxJZZxnCtrTPH9bFUEIeuhSYs4=
X-Received: by 2002:a19:f007:: with SMTP id p7mr37946935lfc.24.1563966886458;
 Wed, 24 Jul 2019 04:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190722185938.9043-1-linux.amoon@gmail.com> <20190722185938.9043-6-linux.amoon@gmail.com>
In-Reply-To: <20190722185938.9043-6-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 13:14:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeRjg3tz-o+_cZ=Xy_ALOL06nODeKbthdrvpQqgYpXhOQ@mail.gmail.com>
Message-ID: <CAJKOXPeRjg3tz-o+_cZ=Xy_ALOL06nODeKbthdrvpQqgYpXhOQ@mail.gmail.com>
Subject: Re: [RFC/RFT 5/5] phy: exynos5-usbdrd: drop duplicate setting PIPE3
 tune signal
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 at 21:00, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Drop duplicate configuration setting of PIPE tune signal.

There is no duplicate set. This is either completely wrong or put in
wrong order of entire patchset...

Best regards,
Krzysztof
