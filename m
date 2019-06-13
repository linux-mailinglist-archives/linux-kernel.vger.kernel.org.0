Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6769F447F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393250AbfFMRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:03:30 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58443 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbfFMRD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:03:28 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7b528bc5
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=eQU47tAOAY4Ww+Qu6JsBiSiAKA8=; b=xZWG9B
        bjHaQeuqbz4sI0NoFYNsm6CSlN9RmsZPoxfj+xDIbapZbChbjilJ2m7GGncMs20N
        Jk3phLBQIRRHb3dAZtZL6zoF6QlbL3y6lZ2AnklPSwrB2xz2YcwdiEgwp02w5uXu
        qvrC5uw1lUeLSVWHuwQ55AXFfz5zOinmXvQgAXZHqfvTW3/WVZlol2YIWPE4vR0J
        tpkuj9lug1NBzBJn/yQIy+o2SMA3JClJThONIoMZSdGlnypeyyz1XNZLLhdIZH+1
        BMZGhuzkOUx9NYzWDecJsdchfvyxrZ9IpuAUpvm/0vP+z2UkIwgg0j0PjtiV3FaT
        niCmGtG5nYujcRAw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 074da687 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 16:31:01 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id l15so19655683otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:03:25 -0700 (PDT)
X-Gm-Message-State: APjAAAW7Q0/feFHrSzwzrS/hPP+A5C09AdXtVck5S+odJfbcauJKlUSi
        Z04W/epMixDGfFySAn2f0mQSaqRmS8PGD6Oha28=
X-Google-Smtp-Source: APXvYqwtl2JJDkqI30n4+ANYJzLJ6c7AVUpnMwMaCK8MzFG1h4OwexbwbWd6Bq6YlRzQ8yXFmAud0QT72VNsUE9HX+k=
X-Received: by 2002:a9d:5a88:: with SMTP id w8mr6898138oth.369.1560445404784;
 Thu, 13 Jun 2019 10:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190529182324.8140-1-Jason@zx2c4.com>
In-Reply-To: <20190529182324.8140-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Jun 2019 19:03:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9rXqA3AwM0=RVMQ0-WFN5OUw_wMvWLOV+6jCDZ6zt51BA@mail.gmail.com>
Message-ID: <CAHmME9rXqA3AwM0=RVMQ0-WFN5OUw_wMvWLOV+6jCDZ6zt51BA@mail.gmail.com>
Subject: Re: [PATCH] arm: vdso: pass --be8 to linker if necessary
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Masahiro,

Considering ARM big endian userland is pretty badly broken without
this, we should probably have this merged in the next rc or rather
soon. Was there additional information you needed? Would you prefer
Russell queues up my patch or did you want to make further build
system changes?

Jason
