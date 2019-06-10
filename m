Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AED3B05D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 10:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfFJIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 04:17:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37118 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbfFJIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:16:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so3336979plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JG4M70b7wkYOvds6yrOcmhpSN1jFaA/ndkV8z9PCnCg=;
        b=dCx0r1Uln/Yq/cC2CsLHVjt9X38n83CZbzG8Trj8IEsLgdhg2knSgN0vXq6RLBywP8
         5w9mNwVO99aKmGDflc7uUmWlPlg6OHS5xkLcxmM6PWRhou+8VEYtkqrMfbfaDE3xoxtX
         f2n9PpI0BYpB9QiekvZhZ6crt54WxHOJK/iNV2251iglNoBa+hyEfV+ws4RGNiIsOCX4
         kj2WhsrhRS7BQWCqJThiHTzAgvYQQWm/WyYhplbOJMfHkP0e03iap7aYx0hPedJmLSBU
         ConuHjLcnhNCkY2ydX6ksbF7UuI5CK6JwdemVkxEJloT3Faf3vFWh2R/q29LNL+MIMGX
         RDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JG4M70b7wkYOvds6yrOcmhpSN1jFaA/ndkV8z9PCnCg=;
        b=RdDYHzpLHzINI0gJ+2R8bRqYM4WIvCt3ez416JzYyql0kwTVa/J4JHUF6+Yd4Irswb
         nT7ti+kZlVIvEKMb2h+zMdDzEikqCsp/2x8+kevUM3MtnwkTWmxakkIfmzriqZhKyLoS
         /mFlJs8nZi/usSneOtxB9yf0xacHIT7BzVnxEBXzMEFcQcemj6MtVh+9B/OlLfuSAser
         t4Pz9HwWOUl81nTianFsKAsO9r1Zmm6dI4p2LbKRLczjpwl9BVJXF6/VeSe80VqYxsgk
         EBXz+f1+RVfOa22zR2fdzLKMo6tlBxXYRXl2Svr3d9hGYU3z9dS+9pas75/A0R/Dwhle
         BSNw==
X-Gm-Message-State: APjAAAXlpkpQ0d0+/7wd+d4I1Orcsk7U6HZodMqnk3dFw3FNjKJS+vt0
        RVtyY1OVa+0NwCO1gtn9lJw=
X-Google-Smtp-Source: APXvYqw0QhU9CP3jm6emUo6eC0uPDlo82/SSJLXOeDE0wuBo8C1m7TMYge+dRuxUGgeZhREDNGOVPw==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr58550853plp.18.1560154618382;
        Mon, 10 Jun 2019 01:16:58 -0700 (PDT)
Received: from localhost ([39.7.57.159])
        by smtp.gmail.com with ESMTPSA id a13sm4104495pgh.6.2019.06.10.01.16.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:16:57 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:16:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     =?utf-8?B?64Ko7JiB66+8?= <youngmin.nam@samsung.com>
Cc:     pmladek@suse.com, andriy.shevchenko@linux.intel.com,
        sergey.senozhatsky@gmail.com, geert+renesas@glider.be,
        rostedt@goodmis.org, me@tobin.cc, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix data type of variable in string_nocheck()
Message-ID: <20190610081654.GA11709@jagdpanzerIV>
References: <CGME20190610074708epcas2p3dcbdc49d114c544c1de721666d574b43@epcas2p3.samsung.com>
 <040301d51f60$b4959100$1dc0b300$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <040301d51f60$b4959100$1dc0b300$@samsung.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/10/19 16:47), 남영민 wrote:
> This patch fixes data type of precision with int.
> The precision is declared as signed int in struct printf_spec.
> 
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>

Looks OK to me.

FWIW
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
