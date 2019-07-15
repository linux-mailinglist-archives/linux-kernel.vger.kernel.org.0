Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6338569811
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfGOPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:15:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39849 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731959AbfGOPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:15:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so11310871otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqjufVPoXvgJvARCtCBUh9v6bqMYapirXw3cBlnyEIs=;
        b=O8dlhQ7tEwCGSNNRtDiyTDb9IWXGI4eiN1ELr1nGeIhobJqOcrFuahArn7YqD+HTvV
         32n1hIUTFBgkn5VPXUIM5Vaz+lyxkXQ0e0JGgXBjKL3trWKM5k4L5n+u+vgibvAcIUva
         dDvIdZYFueg88PuarcxCrfwwHobkjPL5s0W7JTkfRXOV9+880H2F6VvilMljv/vZ/ZEG
         kn9nvqVCDtelv7ArEeZ8Qmnrn4y3ZI966n+ZBJNpXW5qkh6PE2uEsI5Vw8CInGEh7bLP
         5oco2zwc3rYBesv+lffCkdb4eC5fzpeKJ+/3ySKEtZ2Kvk2pvaU1FDLzJc+TpfO00ww9
         kYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqjufVPoXvgJvARCtCBUh9v6bqMYapirXw3cBlnyEIs=;
        b=LUUvyXPMOCmYfZqR1dgdc9JM+mlcj2tvoP4s50lFSeTO5yr3yPS82Kwr92U4DXU65V
         fIYqU6oaixGCV9BsnuV65qwF+OytJYbXQwmkOKnv5Mz4PeHy9w8rmCPud49jHrc9iWpr
         l1lVnjMmFwN/Q7Qw2O9N3tiIQQCNGw7oIXwiWSXYySebRauC9luundby2hWa2iAeN7nd
         EDYe8pVBOqgP/95/TD8J4+p1bV0pR8V/QyOWcJVibvoQ5oXHlSSCKh4fCSdZw7KyyKpk
         UMe9FJlncO3RaV9KOYJIhHCimY8dExuTswrz0NVBxnZPhzB6QvnOG3nuv0RjH9sX8eF8
         YRmw==
X-Gm-Message-State: APjAAAW+GDgbuaLSR5mV7iXHmcukOFSA4fY9h1u/B22RMsp7iWb1dfeN
        KqhHCnG+V7dNk9JbS/RMt9d0PGo6BeFo6iKOnm8=
X-Google-Smtp-Source: APXvYqxb+9cSzZ2YZwM8qbkpbdnL6k33GARlIs2Kr7cuoB90km3/7ggBT9ro2njCwJpou04Vmgesx175RQCsD8JmyQ4=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr142706oti.50.1563203707690;
 Mon, 15 Jul 2019 08:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190712120213.2825-1-lpf.vector@gmail.com> <20190712120213.2825-3-lpf.vector@gmail.com>
 <20190712134955.GV32320@bombadil.infradead.org> <CAD7_sbEoGRUOJdcHnfUTzP7GfUhCdhfo8uBpUFZ9HGwS36VkSg@mail.gmail.com>
 <20190715142754.pw55g4b2l6lzoznn@pc636>
In-Reply-To: <20190715142754.pw55g4b2l6lzoznn@pc636>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Mon, 15 Jul 2019 23:14:56 +0800
Message-ID: <CAD7_sbH9_7DWekJNpfLVjv8Z+JZWH8RK7JiUXM=LP_sMZud6mw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm/vmalloc.c: Modify struct vmap_area to reduce
 its size
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vlad

Thanks for the comments form you and Matthew, now I am sure
v3 is enough.

I will follow the next version of your "mm/vmalloc: do not
keep unpurged areas in the busy tree".

Thanks again for your patience with me!

--
Pengfei
