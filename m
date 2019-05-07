Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC816971
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfEGRny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:43:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37909 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfEGRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:43:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id u21so5975061lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkA+Y9XnOGjl/cdVGrUxZb5095BOcP1bwTD0zYW4RLc=;
        b=Co2UIiT1iv1WhhnvT+1SLlkyQw1jm+jIn7F5nCWplNQ4zzVNCu8DWJlLaOs5Q4eA6v
         dX3/gvVrHWhpmKzMeYWueRW2iIbmxXCiloZEhDBiCwMyJ/AqK/gQeIT/nMiqjhbY4PKo
         2MHqNXryyh0L0banXslg9ahMI3L+ftSr/qVDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkA+Y9XnOGjl/cdVGrUxZb5095BOcP1bwTD0zYW4RLc=;
        b=NlolJnSYr1iwhYDldK7I4XJggfcNwtxtntAjertcc3xkTUHrSfhE2MJghyynl+r4Eb
         YUf55ge3DJg4+sR/05JPpezIbzVReeukwgJGcofb8QNZbAHuMnriCJQPz3EoNDM/sxl2
         MeQEdqSmRvxFDpL25A3iPYRXB1tTk3jZzojWmUTOO2tceciACFMLQAC97ayyi1bZP1uc
         zPZwc7xCH3BNnii9OToZJQ1UGz7l+AdwQTfzbzRRRMGVKQ7ZKnBVoUDxjbHDilvH7wBL
         t2fDuNOu3faTLAeS1w3UrWbMFMzxK3LrVutBVdAAgrt52xblDI9sRi/vkQ+IwBn/bYYH
         7dcA==
X-Gm-Message-State: APjAAAXk6zlJ72qphl2RItU9PxKUPgrKD0BYy+S5eHwOYyuk1uj1qzva
        PM4wXJAwRiNNilHFD1rq2M5D/t9Wfo4=
X-Google-Smtp-Source: APXvYqxwHnQTJ6dyXAB6P9jUo8kSWvT9YPNffLXaDtU8IbZ8kbBDw8QGXYSQVTe3djue+awfT1l3vQ==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr18394164lja.193.1557251031981;
        Tue, 07 May 2019 10:43:51 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y131sm1778880lfc.76.2019.05.07.10.43.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:43:50 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h21so15064830ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:43:49 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr16010057ljj.135.1557251027975;
 Tue, 07 May 2019 10:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190507053826.31622-1-sashal@kernel.org> <20190507053826.31622-62-sashal@kernel.org>
 <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
 <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com>
 <20190507170208.GF1747@sasha-vm> <CAHk-=wi5M-CC3CUhmQZOvQE2xJgfBgrgyAxp+tE=1n3DaNocSg@mail.gmail.com>
 <20190507171806.GG1747@sasha-vm> <20190507173224.GS31017@dhcp22.suse.cz> <20190507173655.GA1403@bombadil.infradead.org>
In-Reply-To: <20190507173655.GA1403@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 10:43:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFkwKpRGP-MJA6mM6ZOu0aiqtvmqxKR78HHXVd_SwpUg@mail.gmail.com>
Message-ID: <CAHk-=wjFkwKpRGP-MJA6mM6ZOu0aiqtvmqxKR78HHXVd_SwpUg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 62/95] mm, memory_hotplug: initialize struct
 pages for the full memory section
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Can we do something with qemu?  Is it flexible enough to hotplug memory
> at the right boundaries?

It's not just the actual hotplugged memory, it's things like how the
e820 tables were laid out for the _regular_ non-hotplug stuff too,
iirc to get the cases where something didn't work out.

I'm sure it *could* be emulated, and I'm sure some hotplug (and page
poison errors etc) testing in qemu would be lovely and presumably some
people do it, but all the cases so far have been about odd small
special cases that people didn't think of and didn't hit. I'm not sure
the qemu testing would think of them either..

                Linus
