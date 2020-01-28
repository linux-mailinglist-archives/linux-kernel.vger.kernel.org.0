Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE614AFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 07:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgA1GPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 01:15:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43686 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgA1GPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:15:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id j20so12259034qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 22:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IX6vC1lqC7B6QSvzPSA4RSu0dRAbEMHe13lqUpG29i8=;
        b=VKXqwFjmNXdB/wJW5knEKaf8vqMoxWZxZenXmtRbHfj2GkPH84URj6RIU7kuu9br/n
         cO100UpGyUFr7n85BLlnvIKAGP009/Hcaf4XQmBvgCO4s5t20dg0E/x5WFuF1JfPexca
         qKucwEcgFyhAQqLSQGzAgwSYxg/Krp1wdD+33iDC3XcjfzHjLG/WmY7kCH57ovDlVBWy
         CInbxtz0nSTJ/aPX70647beyykTi1bIki7ecWq/g+4KVqa/PF299NRyKANNx082/SYZg
         a66f6lAnlak0GqZDiNdAB9xuMjwBEyXfJgmNT0Lq1U8INg0B+xHSCqmhtit3iHj6blvY
         73tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IX6vC1lqC7B6QSvzPSA4RSu0dRAbEMHe13lqUpG29i8=;
        b=ZABCNmSwxHpjaWGjtAZ6pHFsKyQc4cjd/6uePLw5bhZaLU8HfayLeoh6ONTnCDGby1
         OpEMusGNCMHbQ8bEvV2/2JAlDsA1XRBVJLk+UTv4EE1W8jscVkbcQGmKnUdiBAhuzIKD
         naqvcr7Kx2qHRwqfVtKMCQWfNnMePJn3r/a3OCk52xujTNL63N2wCapZOmbtAlfF65m2
         B1ixy6rdgJM23D1ylxMcGNd/gDBoXI3jeJEW0WJO23NJGoOkmmGHi12ajGo3OV0qPOv7
         2IJPn2qgGuM28B4VlPFy5Eea7Ox6fjeZhVM4kcbmr8TuTNIqN8cll2mczPeL5bkdnA4B
         froA==
X-Gm-Message-State: APjAAAVNOPG8/rG1xhU5Pi31ttCgrqwNXklBypa8fSDaz5NGFdJJ0cCQ
        6LKqT6X8zbtvJKds2oDZ4bxXBA==
X-Google-Smtp-Source: APXvYqz7X3XsotDyp2Rkn3xurztaEfQuChOv10+xbCcj0AINYcjgBapre5/9nAD2nqzDixYkJRy09Q==
X-Received: by 2002:a37:814:: with SMTP id 20mr20434739qki.314.1580192124338;
        Mon, 27 Jan 2020 22:15:24 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e16sm11951755qtc.85.2020.01.27.22.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 22:15:23 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: mmotm 2020-01-23-21-12 uploaded (efi)
Date:   Tue, 28 Jan 2020 01:15:22 -0500
Message-Id: <E600649B-A8CA-48D3-AD86-A2BAAE0BCA25@lca.pw>
References: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 25, 2020, at 2:06 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> Should be fixed by
>=20
> https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/

Cc kasan-devel@

If everyone has to disable KASAN for the whole subdirectories like this, I a=
m worried about we are losing testing coverage fairly quickly. Is there a bu=
g in compiler?=
