Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52427129917
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 18:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfLWRKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 12:10:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35729 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLWRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:10:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id j1so11030176lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O43v4gAwFNhQh6twMJkj8FpETaSb8yNo4kWKl5MF01c=;
        b=b94t2WZBmxCa1Ucz5goh4DwvMSvPLfCpKKNRGjA9SwKdlJKd1w8tUlYmhl0qJAHBtX
         /jahl9e1R7AQFi7SzEU2xhx1B5XNbSowt/SfwzGRemYGVAzvvV609ncSzJsdbEgCNfY2
         vmDY6iSw6jYLV532SVBPW4SmPAaCH02ptUiDLx8EjlXPsoWuWiQxhVOndQi/1oqaTEoL
         rDMnJR0QCj/vx+tLBtE/iXjKtYkbIbbIrAIpWta4uDdwCrKCGvao64o2wMufMdFYfiRy
         OXx/7eVI+mgGpbBDbnKiacwqjOeafSVvm3VjQjI1Cxg+ut7YEXyu0Z7CmSNCbXRUvbKZ
         3Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O43v4gAwFNhQh6twMJkj8FpETaSb8yNo4kWKl5MF01c=;
        b=dBCh6S48600vVO8g8hr1dPCV9CY+yqIBD5gscTF5qASQK4MPy+JLFXWGbLgK1Cbc0b
         xZyceYWrvGY4cvaS+guzw/QW5psdqpFOW8JCy2Tqyly4WQOprhtwM2XUDVABJDnaD4fK
         TXpGAq2uEYJTdno4wLRT+Q9/YYrYCBCaHpS5tJWd0Dg/v7+mxagALKlqBo8KBTSU7/qO
         Hd8Wv2U7ath8VCxBpquV2eu8AybOz3RTk65r4gW41mfRsraeTji11if4lbTWksj/clQO
         hsONQa/WNUJ6nfIqMPXlfkHC6Ssm0pVgfycul31bwyspynpMQl9QyilobqqZpM5xgFj2
         DGHA==
X-Gm-Message-State: APjAAAVThGQSvsFOxuVV7eEcyUkN7QC1lsVI81dweg2oLofEgQIH9K0t
        92QAKaZlXfGo805me4E+dQ9Sxw==
X-Google-Smtp-Source: APXvYqytP8y6Jy/gzEfUdcWUxLsy4ScRqWoB0/kts7VDWNphTZEOfK430IYrtbFFwI7iHXvUgyVW3A==
X-Received: by 2002:a2e:8916:: with SMTP id d22mr18460565lji.19.1577121039918;
        Mon, 23 Dec 2019 09:10:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m21sm8627563lfh.53.2019.12.23.09.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 09:10:38 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 75A1F10133D; Mon, 23 Dec 2019 20:10:43 +0300 (+03)
Date:   Mon, 23 Dec 2019 20:10:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Khem Raj <raj.khem@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/boot/compressed/64: Define __force_order only when
 CONFIG_RANDOMIZE_BASE is unset
Message-ID: <20191223171043.g54secptjtqkhuve@box>
References: <20191221151813.1573450-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221151813.1573450-1-raj.khem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 07:18:13AM -0800, Khem Raj wrote:
> Since arch/x86/boot/compressed/Makefile overrides global CFLAGS it loses
> -fno-common option which would have caught this

If this doesn't cause any visible problems, why bother?

Hopefully, we will be able to drop it altogether once we ditch GCC 4.X
support.

-- 
 Kirill A. Shutemov
