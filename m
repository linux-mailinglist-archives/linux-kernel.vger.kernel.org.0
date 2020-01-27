Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5D14A7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgA0QOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:14:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45828 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgA0QOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:14:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id l7so7128098oil.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uD0o49IbMRAvqS+Di3/m9AqswAC6Wc0AWjFfbWqxI4=;
        b=cTbx24Sc+gUWNpMca2hvpg2Zr6gZSyacXR1477KJ/ekO+m5t9sFPyG5oCo0EKM3TI4
         EAud4E6CxPM3d80/1/OYObr6CAU0WQMi5ftGbS9WHym1cWN0N3jNmNTXf+A3282vvqhF
         +MBm03sTNtFGFc4H5g9Okallp/F/ami4yjLfFbnG9GvcKH1irEPIIKg95wMbVYOA3SRu
         Hi/KxoMWUVjnAVi+vZETktpNet4pGIEV2iOBdtZ4zvq+1nIJ4alak66mnkPs3sGqIk9Y
         ykN2AeXuCj9ZuJEba/g1iFyZOakwr3/5YYNQ/J68MDKexrW6Oh/UfZYuzNr83ZAM/Sq0
         Ln7Q==
X-Gm-Message-State: APjAAAXhmfm2M4SGY6QCYv9HU7Ast4PewjbvIdWUXiEr6Oy+oGl/PFkL
        AqWbyF8IO/A3Q0ua+XhyhQv+fKwLhR06MJnsm5Q=
X-Google-Smtp-Source: APXvYqwdHNWixHg7Y+/wZBUzMNgH0rf9wyugpmljHpUiTcmpA31YdcaK3nx5hscQ2lXHBD4KgXIfemOn8RlsaK8/5XQ=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr8087925oiy.110.1580141660938;
 Mon, 27 Jan 2020 08:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz> <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
 <20200127141637.GL1183@dhcp22.suse.cz>
In-Reply-To: <20200127141637.GL1183@dhcp22.suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 17:14:09 +0100
Message-ID: <CAJZ5v0iQDCd1V-78jT0w9_XnhsMbXXhv1gONq9OtOnBCQ3Di2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Luigi Semenzato <semenzato@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 3:16 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
> [...]
> > The purpose of my documentation patch was to make it clearer that
> > hibernation may fail in situations in which suspend-to-RAM works; for
> > instance, when there is no swap, and anonymous pages are over 50% of
> > total RAM.  I will send a new version of the patch which hopefully
> > makes this clearer.
>
> I was under impression that s2disk is pretty much impossible without any
> swap.

And you were correct. :-)
