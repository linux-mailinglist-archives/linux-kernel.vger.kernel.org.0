Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606236221B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfGHPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 11:22:25 -0400
Received: from mout.web.de ([212.227.17.12]:49573 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387932AbfGHPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562599321;
        bh=5jkFKCmR2GUwlsa0zrqotc5apw9/xdj6vpIuoJNsaqY=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=SKo+hJ9/1PmXfDpAFKIy9C+kfYeaDQSYesfdNMOxhtIgtbIXPvTGR3q9sg3l65uTq
         3ZFBvjPPdoF+4jjH+D0lAlV0ctJjL9MFmzxyE/+t0uCp3W0g3oomYFt7Iu01JP3otg
         bA0MAoyAsiaDw8O0TPpw9O0KK9CoslVi+8bNS+iQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.165.233]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxweO-1iY5Jl29zQ-015Fl3; Mon, 08
 Jul 2019 17:22:01 +0200
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1562317084-13140-1-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: powerpc/83xx: fix use-after-free on mpc831x_usb_cfg()
To:     Wen Yang <wen.yang99@zte.com.cn>, linuxppc-dev@lists.ozlabs.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <99840e11-e0e6-b3f4-e35b-56ef4ec39417@web.de>
Date:   Mon, 8 Jul 2019 17:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562317084-13140-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckcR2+VKOSFUJ6uGz6jX9tWXCfRXHX1jSP4nJJRSoovyDhyYsES
 DkzoLdCYgB93ThN0rp+s/yzpSNxRzSHPwuVEsuRVwmNYjgFPY4hwabDTX4BTCmQ2HJzNOom
 7I205/htlkGNrag104lMhr74ihYdlMTHjC2t9Q03CgF/X4hTOyPTiEfrN6k6obTMYPawblv
 ifzD29BWnQf9hE0T4z4eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QcNKnEhYpzc=:mKHsD/6aZzyoV5+get5CTm
 F+8ZlQ5kWQ5FsZAy4hSJOn1z+ODmSfhAymtSao0ltkOLC/sNPoF6E7DIc5hh6jZXQAlC3PcUj
 Ph9LczXpV0Em+5Drpn14EtlOQy4F37LG4eioRL5zNV1mhLtSoOMFqzdAC7MySU/XAVOrWmZ7Y
 tqWdJNGSRVteey01fWui45PiQ0nE0ARMC7w5jV/4JKDHmSSbw9hm/NO0k6eaeJqccyzwe6IaP
 XiM8CkY1QDkz69jLD8ckH3g1LTnTWfCO9iIxs8GOoOIwY+Sj0vtcnzVN33p5/FLBiuj2Nm1O+
 4JZjm+oC8H4gstlAuzqOsnHbTopFuiAk3Ask3g1F4V8KdavIGRpWNWotYrpG/A5Zvfjd2XIas
 DTS1R+66EzXlbPXJIKpQzyabYFktH0hyNpd/jhy06P3TIseBSBMvX4/JEwdyzh6tAs2U+Vwbv
 rIj2n86X5JD6Z9o4/uin4IRVglVd6nGlBhv5dTsGuUupuzAe/vM8B7FRYo12toOLuvqn/IYsQ
 BDmiR46bG3zBaln38qWR/RYtP06Snlp5ulsPNjh9hSksGp7HPIW275OZoJFjNFSjug58s2GVW
 kOGCxnE/+Oa4mD9THzHP4GKerv2EcdkKsVgfDSwsLXIQu9qwrapxF/kO7p31IQdR0rdsMMT3G
 +hWBAKfVKjhFfLwLA0ZvbDc2m2+p6e9aKCkFxPkc17O9NMUf3yc6pJ4NhRPv1us4cwf6Qi3Hf
 tuZ1+Qic9hXcXFnsX1Y1xfeYPj94CB/q8yiMKfYEm5NLmx2Yddn6St+sDsXLt4pyxk0p73GCt
 AeEjEQIf+osQ4Xa9gR0dHXMGfmXHagCRQ8CKhFa+aj58qj9G1o1VB6V5qJOuwrAmNbEhyXewF
 kKpPHPYeivf/pE+h1TtlUeUQc0Quf+9tS2O9LJqlpRt2M0s5dNB3eeFPecWgZFg/oTr74OY3l
 FgJlxScgA8xbMfaJ2kISanglgvSk4NUQ9+d+RF/AV057jLIwd/4TkXdaZuQJxromnR6qvwPhk
 Q9+g5hjqnJlrMLApNDeU633N6sti7ldYy2WurfGcROdKQ4dHY8mhWQ9wNyZCAGRuJsC9+kUq3
 v/mhIc8kXBgI46YaZOOnK3aI9hNTBJ94Si9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The np variable is still being used after the of_node_put() call,

> which may result in use-after-free.

> We fix this issue by calling of_node_put() after the last usage.


I imagine that this commit description can be improved a bit more
(by mentioning the influence of =E2=80=9Cimmr_node=E2=80=9D?).
How do you think about to omit the word =E2=80=9CWe=E2=80=9D here?


> This patatch also do some cleanup.


Should the renaming of a jump label be contributed in a separate update
step of a small patch series besides a wording without a typo?

Regards,
Markus
