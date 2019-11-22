Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2A1071F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 13:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKVMKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 07:10:13 -0500
Received: from canardo.mork.no ([148.122.252.1]:40595 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfKVMKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:10:12 -0500
Received: from miraculix.mork.no ([IPv6:2a02:2121:282:b3eb:68e2:39ff:fe1c:1a78])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xAMCA2ZK024257
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Nov 2019 13:10:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1574424603; bh=Zn0KvcZXnPXpBNWH0DiuFbkAHELGuxXUH0gZ2EV4wlM=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=gqK/ajgLoia9egUwprnScsd5Klkvud9SAB+eXZlaxsx++nPBixAPhBQQIT1Rt83Jg
         12BtRA8K/9bxJILLYRUjpDerUTrPizjTRk6yDb88bl5QFGxkfpPvcVf00ImZSbDLkv
         /a6YsoHa+mR60aGEu/lOkMvhHkVl/nGiwD13J60o=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iY7l6-00073r-PT; Fri, 22 Nov 2019 13:09:56 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     <andy@infradead.org>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@dell.com>
Subject: Re: [PATCH] Revert "platform/x86: wmi: Destroy on cleanup rather than unregister"
Organization: m
References: <20191115052710.46880-1-yongxin.liu@windriver.com>
        <87blt45eew.fsf@miraculix.mork.no>
Date:   Fri, 22 Nov 2019 13:09:56 +0100
In-Reply-To: <87blt45eew.fsf@miraculix.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of
        "Fri, 22 Nov 2019 12:38:47 +0100")
Message-ID: <8736eg5cyz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B8rn Mork <bjorn@mork.no> writes:

> Maybe we should add a WARN_ON(!MAJOR(devt)) or similar to
> device_destroy() to prevent similar future problems?

No, that's definitely not a good idea.  We have examples like
drivers/tty/vt/vt.c which (ab)use the devt with zero major and a
unique minor to keep track of devices.  So forget about any warning.

But the device_destroy's with a static MKDEV(0,0) should be removed.



Bj=C3=B8rn
