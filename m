Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2E194B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCZWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 18:18:08 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44669 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgCZWSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:18:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id 11so3479097ybj.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMAug3DWz0TSaHlbxKB6CB5hPFQDwkF0k5KEtu7t628=;
        b=av4d1pkU3ehBAUGMaoWdCB5066rUk1GBdi/rocNTl+Zl+FcgXm75+D+6TqXVaoDuZj
         bIH2vlCo7H74Z5EZfhnpMUu9lDny8U/LHfMdT9ZpD/7L2FA+rD/KMixlMm9uihpK8XoT
         3OLM4mPYYNA/aKN9XEXdcPZSJOpBs3UyZDLQbfRR+rkm9nfMSXdmnI+J383qnatlaELW
         4X2oIEptirmf9nYH3SGA0bnIX8Ujdr1z605X04LMgWHVHDQyRDmH1v6AA6Z+GML1LHwv
         UfZvinjhLqhUbzvfQKonk90I9bYy3uyF5QNiFahwpp5IN7XlaKclXUDkLo76/gUzzaz3
         p5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMAug3DWz0TSaHlbxKB6CB5hPFQDwkF0k5KEtu7t628=;
        b=TBWQjzBQ1S2M1eNphMPkMYUUVjVYUJlIOV8fNmyZQqTUPXTqABkmHKeJKvSDu/Eata
         NXX5N5tErKXYVD7jMXc+O0J80XvC3M5G8JIrQ5/7iW31KnHn0oEKRMH/TCcwGV0woS8I
         qj9V2A3xLic3Kdhy/FXZEXLJH37bMOpEl/ExA4TbFzKPf69Nw/TAAgKK2I2lnvR7ASGG
         lQHhmd8xC3Wq0045CGnJDPWgI7YuwTlVstbAhjZMJ+RmXi6zTDVhm/CEYsS97CylnguR
         rbXJo+aLpRdoSJp1q90F46wH6Oca39cyLc+h2WalnLqt/6Pk4pVYS/N+jDTtuOhm0Lo0
         yGVg==
X-Gm-Message-State: ANhLgQ3RQCIob5dr75IwvtzDZmnl3Ki2ubsf6ZhfVeNjYNIi0JEJi30S
        BTZeQIHei/laL+9IRtIK5mJxd5sFHp5GvwEH7bdbMQ==
X-Google-Smtp-Source: ADFU+vvnApwiZsKP73hw6IWcwuZ+GZ8XTLu5Ux02Lu70iJ3p+hyi5HVvjnfNkq1llKklVkZgmeV0E8jRVxaZmUJ4JAA=
X-Received: by 2002:a25:4e02:: with SMTP id c2mr398067ybb.504.1585261084799;
 Thu, 26 Mar 2020 15:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <b1c878c0-878a-6684-7cac-d1f4409295f6@web.de>
In-Reply-To: <b1c878c0-878a-6684-7cac-d1f4409295f6@web.de>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 26 Mar 2020 15:17:52 -0700
Message-ID: <CANN689FtZ3VRzAJdHuSP2k=5r9p9QUe08caJpkuRjeLV=hQ9Kg@mail.gmail.com>
Subject: Re: [PATCH 3/8] mmap locking API: use coccinelle to convert mmap_sem
 rwsem call sites
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Han <yinghan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That seems to work too. I'm quite noobish in using coccinelle, so I
wouldn't have been able to come up with that version on my own.

On Thu, Mar 26, 2020 at 6:30 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > This change converts the existing mmap_sem rwsem calls to use the new
> > mmap locking API instead.
> >
> > The change is generated using coccinelle with the following rules:
>
> Do you find the following script variant more succinct together
> with the usage of a disjunction in a single SmPL rule?
>
>
> @replacement@
> expression x;
> @@
> (
> -init_rwsem
> +mmap_init_lock
> |
> -down_write
> +mmap_write_lock
> |
> -down_write_killable
> +mmap_write_lock_killable
> |
> -down_write_trylock
> +mmap_write_trylock
> |
> -up_write
> +mmap_write_unlock
> |
> -downgrade_write
> +mmap_downgrade_write_lock
> |
> -down_read
> +mmap_read_lock
> |
> -down_read_killable
> +mmap_read_lock_killable
> |
> -down_read_trylock
> +mmap_read_trylock
> |
> -up_read
> +mmap_read_unlock
> |
> -rwsem_is_locked
> +mmap_is_locked
> )
>  (
> - &
>   x
> - ->mmap_sem
>  )
>
>
> Regards,
> Markus



-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
