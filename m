Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183A2485C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfFQOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:40:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfFQOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:40:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0D62AF60;
        Mon, 17 Jun 2019 14:40:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Jun 2019 16:40:31 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in
 pcpu_get_vm_areas
In-Reply-To: <CAK8P3a0+jOW==OOx_CLj=TCsG5EBK2ni6kw1+PexJLAC2NEp_g@mail.gmail.com>
References: <20190617121427.77565-1-arnd@arndb.de>
 <457d8e5e453a18faf358bc1360a19003@suse.de>
 <CAK8P3a0+jOW==OOx_CLj=TCsG5EBK2ni6kw1+PexJLAC2NEp_g@mail.gmail.com>
Message-ID: <a05a92b2fdc7c8b7850e9e7c63f8e9e6@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-17 16:04, Arnd Bergmann wrote:
> On Mon, Jun 17, 2019 at 3:49 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>> >               augment_tree_propagate_from(va);
>> >
>> > -             if (type == NE_FIT_TYPE)
>> > -                     insert_vmap_area_augment(lva, &va->rb_node,
>> > -                             &free_vmap_area_root, &free_vmap_area_list);
>> > -     }
>> > -
>> >       return 0;
>> >  }
>> 
>> 
>> Hi Arnd,
>> 
>> Seems the proper fix is just setting lva to NULL.  The only place
>> where lva is allocated and then used is when type == NE_FIT_TYPE,
>> so according to my shallow understanding of the code everything
>> should be fine.
> 
> I don't see how NULL could work here. insert_vmap_area_augment()
> passes the va pointer into find_va_links() and link_va(), both of
> which dereference the pointer, see

Exactly, but insert_vmap_area_augement() accepts 'va', not 'lva',
but in your variant 'va' is already freed (see type == FL_FIT_TYPE
branch, on top of that function).  So that should be use-after-free.

--
Roman

