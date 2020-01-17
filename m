Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B391409C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 13:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAQMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 07:32:18 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:33493 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:32:18 -0500
Received: by mail-qt1-f173.google.com with SMTP id d5so21624941qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9kiC7fmz6Uh8Q6dBYJV3JyDnVoqYdWBAmNfHfXiJTbs=;
        b=FdTonJl3/2+WkHoIpK7agDha8dCJglelXhRdUB8c2Bnq+0+VeDbTwtJqkzRnlQlWfa
         4XJMLp2ncGFIOf/lL8DVWVl1rsd+VRq7GkrXT5eQTpY7wFK6TDO0IJKxwRRxH+IGn+rY
         hegCIwCf5AR1c2uF/NycOyRTS5/uO60PhRiqKOvc0C/E8+zw8SulYjgagN/6INiIhOqt
         CXsp46ALnZumJkhNMIBN7vsxdzour6ikD6W0NiTdczZ5L/6TiuVSNpdnCKS6vTQgayjy
         LVE4zJ2vOv14jA4GWbbRiVWokpG3NvgkIrJR5l7i/yiXpZeEiYybZiLGw3yIfmuKtajm
         UQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9kiC7fmz6Uh8Q6dBYJV3JyDnVoqYdWBAmNfHfXiJTbs=;
        b=HySD4zC/JJ2/Z36mcLojQLxGVt/VEKN957dhxDL2AYMlbfQ3YyiMsur8HTWCxmy3lO
         eGTOT9Hqe0366Ocx51DNRaTf2nsNq8QjMGQg7BDsI2TZvjyGTgB+MNM9ozzkAepW9kRy
         hIgWSl0JT19InGpYko5LUFWNljLsILWGUsKOY4WwzfakN+UdpaOML1QFFm8AgOEB2h5m
         Z3EXKknGWldkR4fsm6vNb2za8X6IyaN07SGbDQQBWggDV3JvyCHO9ppXdd2JkphoMYIm
         tWQbtsNXejX9KSydLGCg+P3dU2UPfZMDD4bOVIBN5mGFlyizeuAzrmn9a8p4ExuKx49w
         OdEg==
X-Gm-Message-State: APjAAAWwN7kvErGKONq9UzRaC9Sef59m4pJjI8gn/n53ZP8Q1sMjwCu9
        AApR/r4Krh0zoCs6jetfsxvnD4JYLNztTw==
X-Google-Smtp-Source: APXvYqyKUBLQGTqUuAKC8yiigsXFvX7mlIRWTZvQo201U73jPoNc2ejeUZN+eHDG2TTFmJ5TeCVR+g==
X-Received: by 2002:aed:31a7:: with SMTP id 36mr7344796qth.67.1579264337269;
        Fri, 17 Jan 2020 04:32:17 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x11sm11781786qkf.50.2020.01.17.04.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 04:32:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 07:32:15 -0500
Message-Id: <9A869A12-E2D3-4952-9103-8444506425BE@lca.pw>
References: <20200117085025.GJ19428@dhcp22.suse.cz>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200117085025.GJ19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 3:59 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Thanks for the updated changelog. Btw. do you plan to send a patch to
> move WARN_ON_ONCE as well, or should I do it?

I=E2=80=99ll send a v5 anyway, so I=E2=80=99ll could remove that for you.=
