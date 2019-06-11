Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C423CCC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390697AbfFKNRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:17:45 -0400
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:38184
        "EHLO sonic316-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388837AbfFKNRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560259063; bh=YR8wGsHZxrVLbZLbTkExH+WvaqI93EK8wnfiRBAnvNY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=k5lIoQVwpZXTHqWCil8IQvmH0gnCRmjC170h8DBKftjDqH3yXrHlpVeuCPyx6jUCHU7MX/8GQLymncIn7SBCP1N06DykL1E8NZCJs2YVYGsgy418E+XwqV3t55Ajea8M1pGXlDbwqet2nWdRpi3MhUX3yFGCQYWDAZSsSoBbRt/Szgz9nc2JuMKpQuxXrwTwpfEGRoY6zIDclwbFz2LGKpSmGbkmmpprWQ3DKyvdjL7XharpVzotPFsUvcvkczAhgmGivyno+fJqQT9xFzKE0aaayocc/3mALwxcffuv4RZq2/7lGk5nfmmZNJ1zn/SQVJ4SBpJVwey0ELkr580Axw==
X-YMail-OSG: wyzuOYIVM1mTwAKarG5v4oYzdTn9hLH9hV7G10xdh_YD6vmN3wwcnyjpPLmJQUN
 urdCqtwgXiDQLcoTQcScWWwiqZ_rl20ujYJvDHpqjWYy7b_uakTf99dQyKcggwCAVJrmnlL9n.N7
 POaVjY9hfmQNJddv7ksiR1T7M_IXYdZkDDWKFM27T4gx0BK.AYHy3c2dm2AHMrAakbxyvdPGXdFy
 zBrPP92NEYGqeqxBmf88U_.wblVKiR2DGGZSIYMa07_MvwwS1_iBVhEB3aUI0ZcnLd5OO3C3G17E
 eWUxH01WG5vZu__nsMYQWHXZ6tCaq8fsXioIcfXTn6Tflp9Y54zpi.C21NdnUMWAArP1Sj2hHkO4
 3ZU.uW304YSlaak.Gi91aUfVaoosX3jPmmtwUX4ySyOuiFu8vyOGnGJ46nZoPhOnrbbTm2LzZlJw
 Uxv6.Xkw0_9YvXIMb3ZnJzGjWrBfOYHN.j.ZB5_kSKp8gkcVhcI5wncYV3PBCJ4OGcfVQotDaEmB
 78QJm.QhcwFEqI53VejgXieVctBmlWStf3RttdXeUheW.0Va1sl9YDEs1_xgl9ZYrsnfX9ioyHS2
 x5upzSBYFsVYeOXwBvBxrlE7NjToatOTgZCdFCM9bZewOz1XZ604GblzynQZ5B1NMepNAJYjl8fm
 1Fg7Y_xG949l3qQew406CsUxELi4eqFDrnLdxPak1K9ROgitUMW9is1n6wGPt0tDP_Mty5iq7qpH
 XLOpl5eCKaIrqLyrHFrxkRJ5U8II.zQnsXEWtK9y94eLqOlP9_hwD8GfuTzwswd0IPUbf1FVBC6Q
 ybAWMREy.C7P2uGabJMZAbMpAi3nPMBaSqq2Fw90tl6JIiXrSyaeiMlzeineKdNU5lu28Ua8gDFe
 Wd1mpnpPADOXC4pDx6c66P9LS.UfLKidxAAmxrCMsLz3Pv2Ee_.emKxcNyiExtCw7.VTVaiuv2B4
 rNEbZ1sUb02JnLsB6Uhi.xIEZ2Lm.ldYRgQexnlieCdHp6heXvU37uYxtcH8ueKVYGMgAteZS6Gt
 3X7PvxnunocsvTiDbizD0PVbWxHFVDUMxy9Q5ULjIxxM79hSeggVr1CLZZcrxuFVd.vYv_eyxh6F
 AJjUxhVf1ynNlKgFuJ0.4GC2BYywoo64CsPC7SdX5oEbpdDDD9rRGndt4wywz7St56Lnf6LEEMj.
 BlZsu56RcbcjzJbtOSVK2gFRGIN1IWe8cBA7gXajyWyAe46SkjpZaDa5c0eY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Jun 2019 13:17:43 +0000
Date:   Tue, 11 Jun 2019 13:17:42 +0000 (UTC)
From:   "Mrs. Maria Johnson" <mrsmariiajohnson03@gmail.com>
Reply-To: "Mrs. Maria Johnson" <mrsmariiajohnson03@gmail.com>
Message-ID: <2136358213.1351287.1560259062307@mail.yahoo.com>
Subject: From Mrs Maria Jornson
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2136358213.1351287.1560259062307.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friend.

I am Mrs Maria Johnson an Active Banker, I saw your email address while browsing through the bank DTC Screen in my office yesterday, so i decided to use this very chance to know you more I have deal of ($10.5 million Dollars) to transfer into your account, if you are interested get back to me for more details.

Thanks for your co-operation.

Your faithfully
Mrs Maria Johnson
