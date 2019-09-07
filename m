Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A6AC448
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 05:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbfIGD4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 23:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390233AbfIGD4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 23:56:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8B2208C3;
        Sat,  7 Sep 2019 03:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567828615;
        bh=7YrNko7HXetW4VBcuIgZksgwHYUgKSmVSaHyJlR2ino=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=nRKaL6VcRNZEsSmfvgkrEJ2PMTT9TSKrk2NoJN/y7oi3WW7NriDU3E34PxXYYzp+v
         TD+zDA1CSTXND7O8UeQ/Oo+g1pOiKE1qRtD/4/NpysNTau5PGGLwzWMtXSHe2FoEWs
         cALHxjeiTgO0nkMlHrz1htCmWj0XjtaYuaaSGhHA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190906235110.15566-1-prsriva@linux.microsoft.com>
References: <20190906235110.15566-1-prsriva@linux.microsoft.com>
Cc:     arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, bauerman@linux.ibm.com
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v1 0/1] Add support for arm64 to carry ima measurement log in kexec_file_load
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 20:56:54 -0700
Message-Id: <20190907035654.DF8B2208C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prakhar Srivastava (2019-09-06 16:51:09)
> Add support for arm64 to carry ima measurement log
> to the next kexec'ed session triggered via kexec_file_load.
> - Top of Linux 5.3-rc6
>=20
> Currently during kexec the kernel file signatures are/can be validated
> prior to actual load, the information(PE/ima signature) is not carried
> to the next session. This lead to loss of information.
>=20
> Carrying forward the ima measurement log to the next kexec'ed session.
> This allows a verifying party to get the entire runtime event log since
> the last full reboot since that is when PCRs were last reset.
>=20
> Prakhar Srivastava (1):
>   Add support for arm64 to carry ima measurement log in kexec_file_load

Did anything change from the last round? Please include changelogs so we
know what to look for.

