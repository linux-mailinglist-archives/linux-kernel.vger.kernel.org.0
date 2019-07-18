Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE06D18A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfGRQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 12:11:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47056 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:11:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so30872604edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3obEXF97WrsMpoUnrYdgG1Tyxfg+JoWnkuCsTAUEfHc=;
        b=nnb8r1VUxoT6Rh7UeZIiyvzQQn0SURlNnsdRcOMXX44NSPsaHqRzm9+BeyWexTq/oK
         98G5MVKnJIUPNWlSW8LoCOppPVI1fyXgjw5MSgUIrawtI1raTD5tKRhgZSMmE1UJromJ
         JREvbh0Pub5P6qZwdP8UlTPAVo8NsB6Ycrw7u2aDcUEaNSRh0gTllpY7sBURLVHjg9+e
         vLMXQz1To95LrzSRCyx7wgBwAb40UW1Sx+H/KUFdPi2alc6fxxUiXC1N2xS0o6KMM0MR
         1J5XUiJ8pwJjJk5G10IHEWpfRfXIbnqd8BFcqGMOAHG+lTa4Xjr6sOR7Omu7U8OIPGry
         jF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3obEXF97WrsMpoUnrYdgG1Tyxfg+JoWnkuCsTAUEfHc=;
        b=JGyXMGCOweZfH1pvbUNYpsPZsLLfXbSwk2D5G4PES1S48hpHnkr3RnRBPJmxX21f++
         wwPz3oBbLUwKKh6U+cEL6QFXuFM+aUAlc/VlI5C8sX6rfSLu4RqMA657eLJDnI1xoniK
         BzqxdWnPZjdLbj6H5JFGhy6LItpG/yQ6iYVl10ykCzGZyGGrygVOSvXj6RwcCrtuJ6DK
         IRxjMPslQ8ycuH4f7OobLGfc9jyrM/+FEGYANRfvzWVQfunv3rDghrd/dr8R/nwlw5UM
         REmrbqeLey6TuAw5Hd0otb+KthSWJklqbWZ9SFwOT0s3YPqiwa7KBs7OdJvM3fcHtXvu
         QaGw==
X-Gm-Message-State: APjAAAUZlEw5mOIlrTzo3tZ4uW9vJr8ch9iAMYPpdgBVvdQZU28hTmiw
        SWgIDUY8AePeRlUXC9+oRM0VIb53m5CjWx2JcSg=
X-Google-Smtp-Source: APXvYqw2EEs0Sl3L+PvArw6obe2M4a4Esh+Ohl1Z2Anp/tQxrPnwrWF0NvTuCVtLVZYl71EJ+CdQj7ghlr5+XD6jjJ4=
X-Received: by 2002:a50:922a:: with SMTP id i39mr41307612eda.219.1563466296738;
 Thu, 18 Jul 2019 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190718024133.3873-1-leonardo@linux.ibm.com> <1563430353.3077.1.camel@suse.de>
 <0e67afe465cbbdf6ec9b122f596910cae77bc734.camel@linux.ibm.com> <20190718155704.GD30461@dhcp22.suse.cz>
In-Reply-To: <20190718155704.GD30461@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 18 Jul 2019 12:11:25 -0400
Message-ID: <CA+CK2bBU72owYSXH10LTU8NttvCASPNTNOqFfzA3XweXR3gOTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in ZONE_MOVABLE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:57 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 18-07-19 12:50:29, Leonardo Bras wrote:
> > On Thu, 2019-07-18 at 08:12 +0200, Oscar Salvador wrote:
> > > We do already have "movable_node" boot option, which exactly has that
> > > effect.
> > > Any hotplugged range will be placed in ZONE_MOVABLE.
> > Oh, I was not aware of it.
> >
> > > Why do we need yet another option to achieve the same? Was not that
> > > enough for your case?
> > Well, another use of this config could be doing this boot option a
> > default on any given kernel.
> > But in the above case I agree it would be wiser to add the code on
> > movable_node_is_enabled() directly, and not where I did put.
> >
> > What do you think about it?
>
> No further config options please. We do have means a more flexible way
> to achieve movable node onlining so let's use it. Or could you be more
> specific about cases which cannot use the command line option and really
> need a config option to workaround that?

Hi Michal,

Just trying to understand, if kernel parameters is the preferable
method, why do we even have

MEMORY_HOTPLUG_DEFAULT_ONLINE

It is just strange that we have a config to online memory by default
without kernel parameter, but no way to specify how to online it. It
just looks as incomplete interface to me. Perhaps this config should
be removed as well?

Pasha
