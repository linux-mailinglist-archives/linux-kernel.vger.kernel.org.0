Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92312BF28
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 21:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfL1UqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 15:46:12 -0500
Received: from mout.web.de ([212.227.17.11]:37995 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfL1UqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577565954;
        bh=oHQaSTGoeH9g17fCUt//b/m5thPO/XUgKQIz9MnXbJs=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=R3+qmI+np0ylYytR0FdVfheC84uzBfCB89d3bNbdQOd0G4yF/X0MgZc0ooHtiwaU6
         3YEBgDVx2bBUhFjqtEjRNEjwo74y3Q7gsbBrhyTpAyZz7saHCmfUDcmASEjtwwKXDS
         bGzPn3xrSJutp4M/eFqJbyQIKngnwZNFWBV3sGUs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.3.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OUd-1jgfvB1o0V-00zTFH; Sat, 28
 Dec 2019 21:45:54 +0100
To:     yu kuai <yukuai3@huawei.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Yi Zhang <yi.zhang@huawei.com>,
        zhengbin <zhengbin13@huawei.com>
References: <20191225131715.3527-1-yukuai3@huawei.com>
Subject: Re: [PATCH] drm/v3d: remove duplicated kfree in v3d_submit_cl_ioctl
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0db93c30-2c87-9824-31be-a15c0d141ab5@web.de>
Date:   Sat, 28 Dec 2019 21:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225131715.3527-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V93mfK/YfZM/BWjKYX3eDbTPdmUzIqmxwkCStPphMhHlROUEMDJ
 JzNKhmfOyXXC6fuW9BKYXavjnfcKgFkMfeWo8a3c8rfvvYZRwNN8tDka5xgrM1dM+1bH4UJ
 VDNEI/PSOhH1ZR2skByHnEM3/O9MFU2QpHscjkYMCH64FpOj7Tm0w5qCbJgitP7IHo/EtHT
 ldDr273rh+6Xj+4eZi1oA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gm+4nD66Xc8=:ksxt2/1ugJOVnrKwiuesG8
 gIMAoRCUDbe3czv1786A7B1YLDdRINwEgwlbK9f2PsBNfVIx/CLC2Kzepkr5sRoWf9m+fqgTD
 WiD0zeuqZL5ugAr6Q9prsRjXnamyIwC1DhfMZzzc2BXDxXvK7fYmZqO0kBivYDMt1jQDtWSZL
 CbiBtztX9gnQaru/DYiO2l0wlFBoeuRq+1EPsY9OD3wIq9gnV/wiFQ49ZeLVDlSWH1mQBmMPG
 PT0IsF2M+6DjQkJLxXdUWYfn29CeVTe7SRwD1xbfy9RuprUp4JuWZfAufyOTQRFRLelUhWKXk
 WTZSECNCKoJePPBsrSkEJT084lmuL0fq1SAqx0OSHLCS4FYPZX9swKST7HY1J+p+37n41hB3B
 ReSb040pXfwqPHGJYUGoskYQpgio5RMQdrbf+LR6anNKz9z6ZmB1SLxzD6Ml8AYBqHaFw5WaV
 Ad5J7/UHGQqtpeqLZi0STuxNje8FDJUA0TP+JbhJ2bkjJH+gmYil19NvVNAz6c6avUMlk1i7u
 plep81+t5moKSESxI/cwjQVYBdGY2eEhPmRO/+f33oRr4rvmXOvTJzXR12Z7U4JqfYgodPuMh
 WG7hj/e8sNcVb2JYQ6DRGUzQOjkVzJ0KGWlIw02/tI3vtzY1xJCTFWmM46SyXnrMXxIIHXRIw
 JxXIAD3UJcZNKJhb47O1vDpHLhG0KHCPYFoXi/XfV+HqW3A9DRiDAMNU3OSjoxFK9Vbdx0VoB
 5VXily5Id5M34Slr+ROHdxdYvR2E/EslQQy03Og6YdS6B78nldQeLsy2O9P0Uqmh6cTEvvSCu
 wQDNMqWPpE1TJBv3n85OUGSVd8yfxeoD8ncHq+PRAvhhXWeLpz0l1U8XZt8VRG+mHJxRE3ioy
 7wD/f7KsXJMknvhwb+VLKEliHFUh0FwTN8JAL1Qs7dFJwl8naxgMHAQ2ibWpRWnH7L4rxB1k7
 waBdue1Fu/IxJGVPNjyvQupGOLeh4weT+zOKrPkXVrfMjQRSBxtqRd6reWJuvYc0qBevAhvZK
 X2wa2qeK0d+GS8MSYDJYdVQoQqFtWrS8I8XHcAcfuOTCM2qjS8AZy5egVUk053Wzq8+ASyyfV
 qRCKAyT4DkekyR53jAdq/pPjmntLZXQAwMPGYrGF9lKibIHopC6/TwRF7VJCApsix3fA6cvU3
 dL3YMYJ1YCzHxpzULRPR20sR6v1umMSnr46HExCJm4BSsTRsC5onZK4lvzb7AuJuSr2pj5FzW
 IDL5bos1asj89MZtuSlnK/tLMbvA8+fEr/qEOscCwvXCd0dzQuhhtTT/xXHg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> v3d_submit_cl_ioctl call kfree() with variable 'bin' twice.

I would prefer a wording like =E2=80=9Ckfree() was called for the same var=
iable twice
within an if branch.=E2=80=9D.


> Fix it by removing the latter one.

I find the wording =E2=80=9CDelete a duplicate function call.=E2=80=9D mor=
e appropriate.

Please add the tag =E2=80=9CFixes=E2=80=9D to your change description.

Regards,
Markus
