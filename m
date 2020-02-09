Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4F156C40
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 20:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgBITcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 14:32:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26492 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727419AbgBITcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 14:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581276769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFbumP/d3NolkXum/s5b1/fcHo6NxOZsWhcDOmqOqB8=;
        b=gTg3+NkowrHyVI9IARc3zdM6Dwq1pzh0cM06i9Gk361E3WSgfvFIMtKVBHs+emvWh6HtmA
        lLuJEeAhQFXOLgYGCAapwv66lr8G2BBkdwBtduEUaGlfVVFBeV5M7cnUTgplPCKfLfpMYB
        LrJF1vCF/JUwHdorh6Jzt8BdqQ8QFUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-AeQNKS88NIiCKNqBoaXYig-1; Sun, 09 Feb 2020 14:32:45 -0500
X-MC-Unique: AeQNKS88NIiCKNqBoaXYig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D57D800D48;
        Sun,  9 Feb 2020 19:32:43 +0000 (UTC)
Received: from krava (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B371719C6A;
        Sun,  9 Feb 2020 19:32:40 +0000 (UTC)
Date:   Sun, 9 Feb 2020 20:32:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main
 kernel map chunks
Message-ID: <20200209193238.GA1907700@krava>
References: <20191223133241.8578-1-acme@kernel.org>
 <20191223133241.8578-4-acme@kernel.org>
 <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
 <20200209150108.GA1784847@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209150108.GA1784847@krava>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 04:01:08PM +0100, Jiri Olsa wrote:
> On Thu, Feb 06, 2020 at 03:10:38PM +0530, Ravi Bangoria wrote:
> > Hi Arnaldo,
> > 
> > On 12/23/19 7:02 PM, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > When a map is create to represent the main kernel area (vmlinux) with
> > > map__new2() we allocate an extra area to store a pointer to the 'struct
> > > maps' for the kernel maps, so that we can access that struct when
> > > loading ELF files or kallsyms, as we will need to split it in multiple
> > > maps, one per kernel module or ELF section (such as ".init.text").
> > > 
> > > So when map->dso->kernel is non-zero, it is expected that
> > > map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
> > > chunks of the main kernel, bpf progs put in place via
> > > PERF_RECORD_KSYMBOL, the main kernel).
> > > 
> > > This was not the case when we were splitting the main kernel into chunks
> > > for its ELF sections, which ended up making 'perf report --children'
> > > processing a perf.data file with callchains to trip on
> > > __map__is_kernel(), when we press ENTER to see the popup menu for main
> > > histogram entries that starts at a symbol in the ".init.text" ELF
> > > section, e.g.:
> > > 
> > > -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
> > >       start_kernel
> > >       cpu_startup_entry
> > >       do_idle
> > >       cpuidle_enter
> > >       cpuidle_enter_state
> > >       intel_idle
> > > 
> > > Fix it.
> > 
> > perf top from perf/core has started crashing at __map__is_kernel():
> > 
> >   (gdb) bt
> >   #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
> >   #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
> >       sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
> >       at builtin-top.c:833
> >   #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
> >   #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
> >       at util/ordered-events.c:244
> >   #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
> >       timestamp=timestamp@entry=0) at util/ordered-events.c:323
> >   #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
> >       how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
> >   #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
> >   #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
> >       at util/ordered-events.c:339
> >   #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
> >   #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
> >   #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6
> > 
> > I haven't debugged it much but seems like the actual patch that's causing the
> > crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
> > map__kmaps()").
> > 
> > Did you face this / aware of it?
> 
> hum, looks like there are few more places where we don't set
> kmaps pointer, patch below fixes that for me
> 
> I'll still need to do more checking and I'll send a fix
> 
> jirka
> 
> 
> ---

I found one more place.. please check the attached patch

jirka


---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..89b0b7713a73 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -686,6 +686,7 @@ static struct dso *machine__findnew_module_dso(struct machine *machine,
 
 		dso__set_module_info(dso, m, machine);
 		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_TYPE_KERNEL;
 	}
 
 	dso__get(dso);
@@ -726,13 +727,23 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
-		if (!map)
+		struct dso *dso = dso__new(event->ksymbol.name);
+		struct kmap *kmap;
+
+		if (dso) {
+			dso->kernel = DSO_TYPE_KERNEL;
+			map = map__new2(0, dso);
+		}
+
+		if (!dso || !map)
 			return -ENOMEM;
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+
+		kmap = map__kmap(map);
+		kmap->kmaps = &machine->kmaps;
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
@@ -774,6 +785,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 					      const char *filename)
 {
 	struct map *map = NULL;
+	struct kmap *kmap;
 	struct kmod_path m;
 	struct dso *dso;
 
@@ -790,6 +802,9 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 
 	maps__insert(&machine->kmaps, map);
 
+	kmap = map__kmap(map);
+	kmap->kmaps = &machine->kmaps;
+
 	/* Put the map here because maps__insert alread got it */
 	map__put(map);
 out:
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..c3dd20082734 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -862,6 +862,9 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				return -1;
 			}
 
+			if (ndso->kernel)
+				map__kmap(curr_map)->kmaps = kmaps;
+
 			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
 			maps__insert(kmaps, curr_map);
 			++kernel_range;
@@ -1145,11 +1148,13 @@ static int validate_kcore_addresses(const char *kallsyms_filename,
 struct kcore_mapfn_data {
 	struct dso *dso;
 	struct list_head maps;
+	struct maps *kmaps;
 };
 
 static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_mapfn_data *md = data;
+	struct kmap *kmap;
 	struct map *map;
 
 	map = map__new2(start, md->dso);
@@ -1161,6 +1166,8 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 
 	list_add(&map->node, &md->maps);
 
+	kmap = map__kmap(map);
+	kmap->kmaps = md->kmaps;
 	return 0;
 }
 
@@ -1270,6 +1277,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (validate_kcore_addresses(kallsyms_filename, map))
 		return -EINVAL;
 
+	md.kmaps = kmaps;
 	md.dso = dso;
 	INIT_LIST_HEAD(&md.maps);
 

