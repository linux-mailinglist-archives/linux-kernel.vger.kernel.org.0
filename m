Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA615D751
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 13:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgBNMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 07:24:20 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41215 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgBNMYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:24:19 -0500
Received: by mail-qv1-f65.google.com with SMTP id s7so4165062qvn.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=GBec5/xP6kdWt5EvLc0p6Ucizf6LIlmy8SX4hwOdeo0=;
        b=Zk6U8qVjpqjndZi63Smi4boGwIJzsRK+eiazK5hQBXuugaUTw5Dzc8vq/QN2FyBLhg
         7QRB0gAoD0NEOS6pIgpQ1lG1utRdUeX+yJGdKF1uu6AGChvP8B380XZ8SH6DTnfIq+Iv
         SUyX+Cwip4UL4YkuWHHNdQ0gc0RwzFBWDz/26pQfywczPMxX86mowu4Y/BG1LiOHg4ow
         hjyrHl/a7eXnKLiYt1VyZAgnBAF87tQNdeZjAyWp6N15jKLuuz0nfV4uGiWFeF981iRy
         UwvhWoZDMZtzgAjIuaZjPijDxSUEV6JtNaVN/TaSHEOmjaMmyvFXHzqqPNMGmxUBWy/B
         k66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GBec5/xP6kdWt5EvLc0p6Ucizf6LIlmy8SX4hwOdeo0=;
        b=sXDj8mJkq4Nk5QLILoUDkeAWjKKEhsxqGQ/i9QkFf9gpZPbkC9J6SZmQ/jYhbo3mGa
         BByGcFjSVlSqKw2HoAVXy/e/H1C7EJMDbhp64dGwrc0J86P8Kjy3KUjOEcpXOn2F05pn
         5ZiNGeFupbabBRq3OKKEt4XbLSMZelxshTMD2WVZ3rT7V8MAMhuGg3edOlXoauqbEPAo
         3H2g3wDr+0P9+/RcvX4VCKpVEaYNbTeOzk+U2O2KAwoXHkzfj9xBCilivavLjtSmNIqE
         IS2SgDhXRp6pHtZqK+FanToL8eVSonDhGCudmaTHzF5UXln3bDogJ7d1055S3zimgYZ0
         25DQ==
X-Gm-Message-State: APjAAAXMnNVDnXwIxSQqBRVFxi80gqYUwiYCMzJtWSbQBGY/+4xvhfci
        rlkoUKnGJmP4c3sbTq/sT9Qmgg==
X-Google-Smtp-Source: APXvYqw12wwBgnZ+aE5voK7VElZoZfWeBTmDb/gdmEW6EqYBN7uM068LeKFlcHNC/RNdxosJuniYaQ==
X-Received: by 2002:a05:6214:1090:: with SMTP id o16mr1874639qvr.105.1581683057171;
        Fri, 14 Feb 2020 04:24:17 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y21sm3086872qto.15.2020.02.14.04.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 04:24:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in queue_pages_test_walk()
Date:   Fri, 14 Feb 2020 07:24:15 -0500
Message-Id: <5AF60E86-F9CB-47AD-9E2C-87EE025911DF@lca.pw>
References: <20200213212639.90c5eef95e4e3a4211dcf0a9@linux-foundation.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Li Xinhai <lixinhai.lxh@gmail.com>
In-Reply-To: <20200213212639.90c5eef95e4e3a4211dcf0a9@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 14, 2020, at 12:26 AM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> I think it's OK.  If this ever triggers the kernel is dead, so the
> volume of output isn't a problem.  And if it triggers, the more info
> the better.

Well, I could think of millions of ways to just add more info for those theo=
retical assertion places where we will eventually be running out of review b=
andwidth if people start to =E2=80=9Cabuse=E2=80=9D it. Anyway, if maintaine=
rs are willing to take risks on that path, I=E2=80=99ll not complain.=
