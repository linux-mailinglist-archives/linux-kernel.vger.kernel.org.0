Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5173E4A036
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfFRMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 08:06:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34777 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFRMGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:06:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so12872667ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eViPuB4mPRtq99GLUYp5aCnnWrpv2fPxaUrqbtshaow=;
        b=OzFHA/skb+Cd3TvWb0I7U3fqoUbEdeAqdN4ud+HZoRnMK7mDQ/vDiz2gc8bfTm+QTg
         oeqqo6aT01GA6E5/kqnmzskzYTF8tBSW8k17FIKLDlQS+5YI2eGyQfgYK29K3shxEUzz
         O4ckLDcVheu7R0/1qdxRgcwXxvoWYbN+8p85sQbLGqoSIIh0MNmhHyWAWBZPZzLfwUvy
         9FTigcgftBfssg9DERYI8X1JJc3SiGtqwT07bDp/iZb+I477c4fnrpgXrqyE1cC+jfoi
         Qzx4J9FPnRKGo4YGVqFJWuhuuWPGdGa/lJlpLIzvJ9HUe+hapnsISe1qzXNxuasMRcaW
         nZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eViPuB4mPRtq99GLUYp5aCnnWrpv2fPxaUrqbtshaow=;
        b=UJ3aHey6OBv8MZCzBBcqu3z9DVQf/S1E2U24HWerg7QA11/v3ovebSbeuJxUEN4EGi
         WMafGhhQu5P/H9dD8co5iTIQ09A6FVgyXu7iDJqLaE1C96bDykCrOTYKLFUw4biE6DPL
         +56v1XovExxnKhCX4cO8oDIuBcfgwpAfQE6e7QAeBI9NYMUdIqlNylAYaK3CPOYcCH9C
         7Z62p1zPXVjNtJsVHovNW1ksyV/SCz2EMCpI84hIp8/x4Zxn4elFXSMHWyNpNxF07lIy
         oRdunEb9/zJiEiv4MghHLpjDMdiN/nW90cCmHR/tjyBs9f9Sf0d4yjQNx56lr+V/XyLE
         jovw==
X-Gm-Message-State: APjAAAUXulyPd8EX0WRcXKP6XCKpzUnjkZ3xbtnj0MH5XD+UGE5BW9Bp
        N8LDGTxRFHhf62we/pWC0kfIJpF8/H8k4G5P+zeQLg==
X-Google-Smtp-Source: APXvYqynedWWS6RMfN+pXeWLkf2H5DM5H4yMJ5FcjVlUXuJ+N1JPU/Ap4AsjrjX3+umUXW+mGzRZGfQvvOr3ws24C8w=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr21465480ljh.149.1560859561469;
 Tue, 18 Jun 2019 05:06:01 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jun 2019 17:35:50 +0530
Message-ID: <CA+G9fYufHb5N_NMd4RQnr3jJjqQ8b4Nj1CZXecWvDQPohFUewA@mail.gmail.com>
Subject: next: arm64: build error: implicit declaration of function '__cookie_v6_init_sequence'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux -next build failed on arm64 and arm.

In file included from net/ipv6/af_inet6.c:41:0:
include/linux/netfilter_ipv6.h: In function 'nf_ipv6_cookie_init_sequence':
include/linux/netfilter_ipv6.h:174:9: error: implicit declaration of
function '__cookie_v6_init_sequence'; did you mean
'cookie_init_sequence'? [-Werror=implicit-function-declaration]
  return __cookie_v6_init_sequence(iph, th, mssp);
         ^~~~~~~~~~~~~~~~~~~~~~~~~
         cookie_init_sequence
include/linux/netfilter_ipv6.h: In function 'nf_cookie_v6_check':
include/linux/netfilter_ipv6.h:189:9: error: implicit declaration of
function '__cookie_v6_check'; did you mean '__cookie_v4_check'?
[-Werror=implicit-function-declaration]
  return __cookie_v6_check(iph, th, cookie);
         ^~~~~~~~~~~~~~~~~
         __cookie_v4_check
  CC      net/core/net-traces.o
  CC      drivers/char/tpm/eventlog/acpi.o
  CC      fs/proc/page.o
cc1: some warnings being treated as errors
scripts/Makefile.build:278: recipe for target 'net/ipv6/af_inet6.o' failed
make[3]: *** [net/ipv6/af_inet6.o] Error 1
scripts/Makefile.build:489: recipe for target 'net/ipv6' failed
make[2]: *** [net/ipv6] Error 2

Best regards
Naresh Kamboju
