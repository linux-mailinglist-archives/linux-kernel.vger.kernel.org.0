Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFF1092CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 18:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfKYR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 12:29:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33457 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKYR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:29:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so7714290pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=yQi4UEnS+V4u3juz38+xrNNa68rc8Lco57qfpAZ4Ncw=;
        b=XOUbVwSrwqTDHrN5RPfcILKGSTKyseJzoF72gL9Y0TN/mpORTlPlyTlikUGenHXFND
         SR/kZK2QIc3T9jWNDOTihkJQ6AFcmW+HHj84r/sNfP5UBA5qGxO/gSctZphhjoKQwBFH
         uC1aYCTAVW3OKaJXTj+JsmUkHB4moc6e+CENPt5lGStlC8eIWr1+6I8Mf2d03EvwINTs
         GTUzXY+wWkGh+FEbOCuXFWsZJpvvpkXPYR5RFnieqBu/GdNucSMHOx6hZ9NpVtlghAUM
         YLKu7Eu6lQXzpeHUeZFdTTdqgz7dy5f+GCRek7PKb1pd7Ft/GukdOaAh6UKGKSJ6/6OM
         eYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=yQi4UEnS+V4u3juz38+xrNNa68rc8Lco57qfpAZ4Ncw=;
        b=IaU5YMvwlK5ZqBgS3YEtf5pi2dpPR50CuU2WDspRvyTlNmpJhg6mOVq6ENzLkg1qa/
         3oAQVoZuUx4EpTfY5UTOlL50+mgsvHYPCTNzCh5dlqaQUVEr6ZE+wb3piJ3AhbDxa5B9
         jVzupxQgd+VAK5cZL2ZjjfThzZcHYbUoUg7brsaftKCVBBcj6seKvlkO/HiWGunQW7Yp
         ZeFUxUSJcpCjq4e7QvbzB2+vTt0EC+wfS59/vNaaMaNa8GvHALFPBYbLy0xsUubWAixb
         Koh/iBldzSvocV8gCORx4RqQPxTJv7pHy23ZJJQ5JaydWQaW/hhja4krU2QzzurVo1Ed
         4W4A==
X-Gm-Message-State: APjAAAXhctHLSL7T3xflNfkgERY5y+RdHhoQX1/sgQfVOMygED6ndnSe
        fb73EH/TXgLS9urZafnyYJO/nA==
X-Google-Smtp-Source: APXvYqxRiSCtDfFbE9taYkfXX9N0Ym7p7haFk+ZjP19G8KpgpI0PxLMHYcwghp6Xp4Ci6gUbGSXn+w==
X-Received: by 2002:a63:3409:: with SMTP id b9mr20273251pga.320.1574702939703;
        Mon, 25 Nov 2019 09:28:59 -0800 (PST)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id u20sm9183075pgf.29.2019.11.25.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 09:28:59 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:28:50 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phong Tran <tranmanphong@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net,
        luciano.coelho@intel.com, shahar.s.matityahu@intel.com,
        johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        sara.sharon@intel.com, yhchuang@realtek.com, yuehaibing@huawei.com,
        pkshih@realtek.com, arend.vanspriel@broadcom.com, rafal@milecki.pl,
        franky.lin@broadcom.com, pieter-paul.giesberts@broadcom.com,
        p.figiel@camlintechnologies.com, Wright.Feng@cypress.com,
        keescook@chromium.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: net: b43legacy: Fix -Wcast-function-type
Message-ID: <20191125092850.2cc451bb@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <07e73c3b-b1fa-c389-c1c0-80b73e4c1774@lwfinger.net>
References: <20191125150215.29263-1-tranmanphong@gmail.com>
        <07e73c3b-b1fa-c389-c1c0-80b73e4c1774@lwfinger.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 11:26:31 -0600, Larry Finger wrote:
> On 11/25/19 9:02 AM, Phong Tran wrote:
> > correct usage prototype of callback in tasklet_init().
> > Report by https://github.com/KSPP/linux/issues/20
> > 
> > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> > ---  
> 
> This patch was submitted yesterday as "[PATCH 3/5] drivers: net: b43legacy: Fix 
> -Wcast-function-type". Why was it submitted twice?

Because the series was split between wireless and netdev changes.
Tran, please make sure you include a note about the reason for reposting
in the cover letter.
