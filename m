Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5930CED4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfD2XXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 19:23:42 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33603 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfD2XXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:23:42 -0400
Received: by mail-pf1-f179.google.com with SMTP id z28so788480pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YNd5XIwM5sGIOIL8C1Ttqmlb7fzBV2yqKuzpj9z/xNY=;
        b=ab1DViiwuT34vHIps7vB/KNE1BO5BonTPRVwKQE0PrPQTTpdiCtcaNK63Bidkc/mNK
         pyaohy4NXFao34rOEaPmshyXKcMsOvfpYDr9+DLdi9AHxnUXgHl+chSGx8/p4GKaHrK7
         keQDOgdPMFEZeYK/8kfOfWp3NcRVQTyRWHRKU992WZa4YAuO/3T5UZEYnsqRU00exL4J
         V2A6rGUs5Y1F9nbzKS6nlP6IwqVImW2LXwMaQoQOeGTUL/JaWwxKlq1BsEJ4yP/pn0vx
         Xume0+/+QcXdhcfvgLX18liPAwEIohhRMFRNPMiEOzBfEwiKo3uQP63nZQEsIiOI00oQ
         oC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YNd5XIwM5sGIOIL8C1Ttqmlb7fzBV2yqKuzpj9z/xNY=;
        b=FqReBepuyFQwWbJDMuF+E8V+aNip7AaxLX7U84k23nvmDx6/DNBgPIz5Ry+wTGKMF4
         LS/TFqNsc7AgEXxS5PScsI9rz4xAg1VnRu24LiuehpkBQWy7QIV0CFTftSJF6X/aofvo
         4ZENSMgKyl3AmDk/MFuWUqATTGhsSLoQpTkxUGlA4mGVk3yzzYNj3eoxgAdV5BGGRLQf
         rPnz5GGSC5Iq29W2qjTvMd7KCbiucVqDYAnmHOC/GIvk5Koh7pEc18gzUdZWBcFzTZQv
         IqGDoiZBXRLhSSYhqsx5VsfVOTyita1q3qeojv9FRWS5ZGqYVoJSCVaZ5Zr4/ayjHuEr
         8Zpg==
X-Gm-Message-State: APjAAAXWr8Fwe2QJ0ZYp5ZpnGW/9XaETobv2bfvkXsul2vLeR8D4SI1Z
        2hMpytUOVvcyJwCmZi2NruM3kw==
X-Google-Smtp-Source: APXvYqy0pkiYAo4kNCFYdQsYAUNSH2awhHznPjw5awZA0OodMxIfPtIaWKtzt1knemtdMwoGkGJxFQ==
X-Received: by 2002:a62:5885:: with SMTP id m127mr32599935pfb.33.1556580221466;
        Mon, 29 Apr 2019 16:23:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l15sm22555931pgb.71.2019.04.29.16.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 16:23:40 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:23:40 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:23:33 PDT (-0700)
Subject:     Re: two small nommu cleanups
In-Reply-To: <20190429115526.GA30572@lst.de>
CC:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-3cb7e3ad-f586-46e0-8c29-48ab828607d2@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 04:55:26 PDT (-0700), Christoph Hellwig wrote:
> Any comments?  It would be nice to get this in for this merge window
> to make my life simpler with the RISC-V tree next merge window..
>
> On Tue, Apr 23, 2019 at 06:30:57PM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> these two patches avoid writing some boilerplate code for the upcoming
>> RISC-V nommu support, and might also help to clean up existing nommu
>> support in other architectures down the road.
> ---end quoted text---

I don't actually see any patches, can you point me to something?
