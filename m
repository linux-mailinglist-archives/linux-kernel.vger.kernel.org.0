Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB6240AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 20:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfETSua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 14:50:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46954 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfETSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:50:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so7637677pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Mv8Qa01JCZ4+I7YNJRvGCUwkERJCFxGoPpOGVqFUsYA=;
        b=LzRo5Nb6F7TFwyy5bp3FMP6UKmKwdrKZBYV8OY2LiLicrsrHoaULjsXjHJUAzLZd8k
         akZ3bPYdZmgJHme2EODuIbrNd27cGXCSVd3r9GC7LhchRa04f6VzMH8AkZpMUIT4rm/g
         aZ20HGwlSiT8tpEYkKhXuRRoqPdu6dO1WOBM/xXpenFNiYXmu2wsIMYj4eGk9ecb4gCv
         tExdPIBkotN5XCXJpRIP2iv0ohdLdY4JCioDie7Bb/G3f3M2PsZA1faLwLJ3J8hIS5gE
         CC/1Wqmcu34gckeSxDEtpR4JXa3n7ubgRnvoeysbbPATSjhpkHNwLJi8CQqwC/kjvEBg
         a2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Mv8Qa01JCZ4+I7YNJRvGCUwkERJCFxGoPpOGVqFUsYA=;
        b=J7u3ibxwEX17ca9xTTASCnhcZ/XHpvEc978lyBAtix7PS+1b5LMSa3XFGdj+vJxhy1
         hj29HYpnVEl1OuQ1Eho350DTMLG4wSw2iXy5vfRgA1XurlnyELOBm2upONGfaT0fnZiZ
         xrcnjhVjxsInoc3hRwsgdVrAYjNAxKuFALE7xCGZVdjGayl+aPggwbkHf12D1uzPqvPK
         Et62N9Mg+D+kNHvoQnPZgJ0d2s3oQ2s3ek/fauG8W9Sy54/+sYY2EK3sQhKFKBz47nsM
         U6AiZJqRwcACYErqo10DTCwS8Vrezr2QUsIHBNB99vBY9nNzD1i34AvDeTeuJuB62hDv
         FicQ==
X-Gm-Message-State: APjAAAWmb7MJT69FYywt8+KRpB7aqT/tlvw6Nuy3hnxxs07e3WhIB8tE
        ELtT5eg0bKPiOY1SSubxDrFKjQ==
X-Google-Smtp-Source: APXvYqyeVgJuq88BvtgUgTuL8byweGUANYm5SR4s6iLuwa5yxXyYVn/e5ZPLOh/EoEtmF45cm1pG+Q==
X-Received: by 2002:a63:5964:: with SMTP id j36mr76640076pgm.384.1558378229131;
        Mon, 20 May 2019 11:50:29 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id n184sm25492567pfn.21.2019.05.20.11.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 11:50:28 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: meson: g12a: add ethernet support
In-Reply-To: <7himu58195.fsf@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com> <7himu58195.fsf@baylibre.com>
Date:   Mon, 20 May 2019 11:50:27 -0700
Message-ID: <7hd0kd7yfg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> Add network support to the g12a SoC family
>>
>> This is series is based on 5.2-rc1 and the patches I already sent last
>> week. If this is not convient for you, please let me know, I'll rebase.
>
> Could you apply this on top of the "consistently order nodes" patches
> that are already in my v5.3/dt64 branch?

Nevermind, I mis-read the above and thought it was on v5.2-rc1, but now
see that it's on -rc1 + all your other series, so it's all good.

Kevin
