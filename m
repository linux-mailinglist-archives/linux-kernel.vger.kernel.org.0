Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C61184E92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCMS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:26:13 -0400
Received: from m176151.mail.qiye.163.com ([59.111.176.151]:15134 "EHLO
        m176151.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgCMS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:26:13 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2020 14:24:52 EDT
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
        by m176151.mail.qiye.163.com (Hmail) with ESMTP id 915D0482052;
        Sat, 14 Mar 2020 02:17:38 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIkAvQC8CBiKb1HKth-6ZqrH.3.1584123458318.Hmail.wenhu.wang@vivo.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, trivial@kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2Ml0gcG93ZXJwYy9mc2wtODV4eDogZml4IGNvbXBpbGUgZXJyb3I=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <320843ad-32d5-8799-7c4a-150fa5fd7ef8@c-s.fr>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 14 Mar 2020 02:17:38 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Sat, 14 Mar 2020 02:17:38 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VJSUtCQkJMSkxMSklPWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTUNJT0NLS05IN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MhA6DSo4Qzg5EjAZSjMwDxNWTSEKCTNVSFVKTkNPSklIT01KTU5NVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQU5JSU43Bg++
X-HM-Tid: 0a70d51db42c93b5kuws915d0482052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Y+R5Lu25Lq677yaQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjLXMuZnI+CuWP
kemAgeaXpeacn++8mjIwMjAtMDMtMTQgMDE6NDU6MTEK5pS25Lu25Lq677yaV0FORyBXZW5odSA8
d2VuaHUud2FuZ0B2aXZvLmNvbT4sQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwu
Y3Jhc2hpbmcub3JnPixQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4sTWljaGFlbCBF
bGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PixSaWNoYXJkIEZvbnRhbmEgPHJmb250YW5hQHJl
ZGhhdC5jb20+LEthdGUgU3Rld2FydCA8a3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZz4sQWxs
aXNvbiBSYW5kYWwgPGFsbGlzb25AbG9odXRvay5uZXQ+LFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPixsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZyxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnCuaKhOmAgeS6uu+8mmtlcm5lbEB2aXZvLmNvbSx0cml2aWFsQGtlcm5l
bC5vcmcK5Li76aKY77yaUmU6IFtQQVRDSCB2Ml0gcG93ZXJwYy9mc2wtODV4eDogZml4IGNvbXBp
bGUgZXJyb3I+Cj4KPkxlIDEzLzAzLzIwMjAgw6AgMTg6MTksIFdBTkcgV2VuaHUgYSDDqWNyaXTC
oDoKPj4gSW5jbHVkZSAibGludXgvb2ZfYWRkcmVzcy5oIiB0byBmaXggdGhlIGNvbXBpbGUgZXJy
b3IgZm9yCj4+IG1wYzg1eHhfbDJjdGxyX29mX3Byb2JlKCkgd2hlbiBjb21waWxpbmcgZnNsXzg1
eHhfY2FjaGVfc3JhbS5jLgo+PiAKPj4gICAgQ0MgICAgICBhcmNoL3Bvd2VycGMvc3lzZGV2L2Zz
bF84NXh4X2wyY3Rsci5vCj4+IGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfbDJjdGxyLmM6
IEluIGZ1bmN0aW9uIOKAmG1wYzg1eHhfbDJjdGxyX29mX3Byb2Jl4oCZOgo+PiBhcmNoL3Bvd2Vy
cGMvc3lzZGV2L2ZzbF84NXh4X2wyY3Rsci5jOjkwOjExOiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24g4oCYb2ZfaW9tYXDigJk7IGRpZCB5b3UgbWVhbiDigJhwY2lfaW9t
YXDigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+PiAgICBsMmN0
bHIgPSBvZl9pb21hcChkZXYtPmRldi5vZl9ub2RlLCAwKTsKPj4gICAgICAgICAgICAgXn5+fn5+
fn4KPj4gICAgICAgICAgICAgcGNpX2lvbWFwCj4+IGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1
eHhfbDJjdGxyLmM6OTA6OTogZXJyb3I6IGFzc2lnbm1lbnQgbWFrZXMgcG9pbnRlciBmcm9tIGlu
dGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XZXJyb3I9aW50LWNvbnZlcnNpb25dCj4+ICAgIGwyY3Rs
ciA9IG9mX2lvbWFwKGRldi0+ZGV2Lm9mX25vZGUsIDApOwo+PiAgICAgICAgICAgXgo+PiBjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwo+PiBzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkOjI2NzogcmVjaXBlIGZvciB0YXJnZXQgJ2FyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1
eHhfbDJjdGxyLm8nIGZhaWxlZAo+PiBtYWtlWzJdOiAqKiogW2FyY2gvcG93ZXJwYy9zeXNkZXYv
ZnNsXzg1eHhfbDJjdGxyLm9dIEVycm9yIDEKPj4gCj4+IEZpeGVzOiBjb21taXQgNmRiOTJjYzlk
MDdkICgicG93ZXJwYy84NXh4OiBhZGQgY2FjaGUtc3JhbSBzdXBwb3J0IikKPgo+U2hvdWxkbid0
IHlvdSBDYyBzdGFibGUgYXMgd2VsbCA/ClByZXR0eSBzdXJlIGlmIGl0IG1ha2VzIGEgZGlmZmVy
ZW5jZSh0aGF0IEkgZGlkIG5vdCByZWNvZ25pemUpLiAKRG9lcyB0aGUgaW5jb25zaXN0ZW5jeSBv
ZiBDYyBsZWFkIHRvIGEgZmFpbHVyZSBvbiBjbGFzc2lmaWNhdGlvbgpvciBzb21ldGhpbmcgZWxz
ZSB3aGljaCBtYXkgY29uZnVzZSB5b3U/Cj4KPj4gU2lnbmVkLW9mZi1ieTogV0FORyBXZW5odSA8
d2VuaHUud2FuZ0B2aXZvLmNvbT4KPj4gLS0tCj4KPldoYXQncyB0aGUgZGlmZmVyZW5jZSBiZXR3
ZWVuIHYxIGFuZCB2MiA/ClRoZSBsYWJlbCBmaWVsZCBtb2RpZmljYXRpb246ICJGaXhlZCIgLT4g
IkZpeGVzIiwgd2hpY2ggbm93IGlzCmlkZW50aWZpZWQgc3VjY2Vzc2Z1bGx5LiBSZWFsbHkgc29y
cnkgZm9yIHRoZSBmYXVsdCBvbiB2MS4KPgo+Q2hyaXN0b3BoZQoNCg0K
