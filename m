Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB75122FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 16:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfLQPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 10:09:36 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43548 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfLQPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:09:35 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so4268862qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0OkMwroxaFTIfHX5v7BwxiXC57WOkvd1SruP9P6F2gQ=;
        b=AqbMRymX9CPH4mO3hD6Uyz9s6YZsLavTX4LxKYda/0ELAak4kzRE/RPLbedix3FfB0
         iMU1mgu77Wqy0j6Psmm6DAK2UifEGoCWvQkAdq0VDBDHBCGfYG8T0kBkkTEsN0g17kV3
         8EbFihrTBwEGteAhyplEHTnvjYsRUIDBoj5hS4K4q124bMhSAJotdOEjqgfDlUgFjOPF
         23cIZboMOWo821f2gNCNtFM5cbbe/0QbiTU2VKtAItwRPgpSOLR44cx5UjESNPh+Q8Dv
         jbdD8EQ+hwNjT09z+o9vDTcAnTa1GdT4TGp05AaKX5pCPe8xB6IPgMYE5tZY9pBSJC8O
         eh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0OkMwroxaFTIfHX5v7BwxiXC57WOkvd1SruP9P6F2gQ=;
        b=kbUOplV9PhvsdqE/Yymkv/Gz7wxZYsNluwKpZFeE3mQBVvuFo/MM71jIEcZU8NFnoF
         Zb7XU6CVIkp/5gmapVgb9Be4zSCsHjVkTF98RkSTWDdWU7WyowZ+Pr0L9KYRtyH5KLpa
         xARWHE+Twn6dilUwsQn9tXwG7QWDUGU8mc6TI8WbRrmjZXfG2si9RfVAKn17Dj7eblEf
         dZZG9Dv2lE5ay2VKsLUiJ5gfJwcyNFiJzg4rz+szDLKqWHp2RGB45Az9KLLmSxMZb96u
         X20ei2DD/4OyDTvhvTKZNLIPmmevLXN/+vwwiQaKOuisHKKXRWcneDVoQ+m+LGBZb+wr
         POzQ==
X-Gm-Message-State: APjAAAW/9q/2kkqqTbHTXCeozFZYSALF0KH0jv4KR4zpTg6/B8gQvLdl
        EWUHHf6h3tMdNytDAR8orbMDgg==
X-Google-Smtp-Source: APXvYqywK6ioDEXZv5myk3NMkzoATz7qETU5xLGU5chMhRL1F3ITK58LT6S9ttP9tEzds/UoMxL0nA==
X-Received: by 2002:a0c:f703:: with SMTP id w3mr5069817qvn.6.1576595374810;
        Tue, 17 Dec 2019 07:09:34 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm7055010qke.85.2019.12.17.07.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:09:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:09:33 -0500
Message-Id: <5D853968-99FD-4B66-9784-C1C540B23F92@lca.pw>
References: <20191217143720.GB131030@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217143720.GB131030@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 9:37 AM, Chris Down <chris@chrisdown.name> wrote:
>=20
> I struggle to imagine a real issue this would catch that wouldn't already b=
e caught by other means. If it's just the risks of dead code, that seems equ=
ally risky as taking time away from reviewers.

Hate to say this but ignore unrealistic configs compiling test should not ta=
ke that much time.=
