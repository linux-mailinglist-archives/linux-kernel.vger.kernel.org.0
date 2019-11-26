Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A8109788
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 02:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKZBW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 20:22:28 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36964 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:22:27 -0500
Received: by mail-pg1-f180.google.com with SMTP id b10so8119191pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AtPRMYJsiWkwHiFFHZwBcUcKfK6FWEVPRzt0kULjoMk=;
        b=ZsjGN9G3y6QPq/SuMUBdQdPjWMaaqGTsg369cIOxGzFWf76C6KhXoa28fC3PDPNsv+
         7QWs10eF6lz9is8be53GzoigIeoomf7xOruNp1Y/bJBePCpSOXYLOA4H2/KJ77cRhk05
         x0KvyJoRGbdZ9bbhy/XpP674iOcUGGYfS/H2W20tUStvBWi2ytsJmsFm0cuVxx0LrVhE
         fJVgEsvqgV4FirojN5oa+BaOcKBvYRvapbjhDDbYa7cJEo8dtqNlxLA6y+V/jXxspakD
         Spg4rGfGWHPFYnszQbpNq8GQ03LpilTeTOS2V8qw2dZ1gjduJRffPZoij6u5G0iQYIDa
         y3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AtPRMYJsiWkwHiFFHZwBcUcKfK6FWEVPRzt0kULjoMk=;
        b=OaJXs214OUSEfQmCosj+NZaYHxnyhNs1l7PCiAjKKZvNt8qrXnaaCjLuLtjWx2VNch
         cDXInf6doZzxiX7F6uVLdfUfkI/agMK97ufc8RNmT0fmKxoEg/5SUTWoKj0LqwU7Th0q
         4Ye3YEIBuNmUE5fU8+ieSTIQ3WaO9hqDBRcoOtUh8sQFag8f8ko0M5FVGXFNHg1rVKiI
         Ps/kXFugVOcuMzAwpeMQ0rf+ofYME+YwDdTdTV9RpppluZLYNGE6ZqOWmVweu90I9xL9
         jOBfAhdnefK3vODaFst1ce7+pJRMY9E1vFPxI+3eC3lpWDoYN8BSBtKP2Oy9Lwqniud+
         WtXg==
X-Gm-Message-State: APjAAAW20nh3yPpbEKL8ettCmhibKg51gCOOZL/b7EZ9H4M+lOLCJr20
        wWjJ8/D9b+rQhvj22OESyTW5lqrUXCg=
X-Google-Smtp-Source: APXvYqzCduZpVjmTaqiZExnNw3OMBfwJqTBjnW12KeeSXsvhWXRVkr9xrQzORP/oWCYG2oNVoKbw8g==
X-Received: by 2002:a63:6a47:: with SMTP id f68mr35998951pgc.35.1574731346647;
        Mon, 25 Nov 2019 17:22:26 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r15sm9985094pfh.81.2019.11.25.17.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 17:22:25 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: Amlogic 32-bit Meson SoC SDHC MMC controller driver
In-Reply-To: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
References: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Nov 2019 17:22:25 -0800
Message-ID: <7htv6rh1ny.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> this is the first non-RFC version of the driver for the Amlogic "SDHC"
> MMC controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

This will need to be reviewed/merged by the MMC maintainers, but to get
some broader testing (including in KernelCI) I've added this series to
the 'testing' branch of my tree so it will be included in my 'integ'
branch.

Kevin
