Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C436B1298B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 11:29:34 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35368 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLWQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:29:32 -0500
Received: by mail-wr1-f47.google.com with SMTP id g17so17179444wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vw4KPbMTBUV8sBhtBOLETSLchNFJLtEKQMemtAhU5f0=;
        b=HILnxJrbx3T6SzDiiixqtE05Gi5pWp10VpWyCZky/8WbvfiXsgKT041EAJlLBenpwQ
         fyU2PejkZ54nk+wiOErY6mKIWP73+QNq3mi8A4cdmt0y8eUmj56M2YRjR/7XtLnKK9r1
         6RZzJozOV2vq6X/DKdGOzhXs3GjtX5sYUQhKMeDGfXoLpyaplYL8yVZ9tYz1NdJFs3ae
         zqgD1F1eCJlN69OjzY9L1WtnD+WlED1DrZ/bFQHLJOnI3lTBXysarcxGNIXV2N+MfKHh
         3eb+kByeZq8Velzl9fn9SpadwonD+0kqkyNosFr8l7WM2B8OoZST46JtWDgoJB45NJ4F
         S+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vw4KPbMTBUV8sBhtBOLETSLchNFJLtEKQMemtAhU5f0=;
        b=pr4E68PteHla0fWH+Gl9j33OIZ1VqbXHeOO6FgiId3KnNeScCRidYbJusc8uF129xN
         1JoVvizJdVj5nBTa70U+Ld4rLJ8FPvNfshfhlU1yMVj/cms4YAHQEzMakwoEghZT/fe7
         I1Ob63BAJ2EdCMqK7GPYEl+CeGkIMv68xl9Xb3BSMeGCSCFJljLFUYQ0yA8qGeLzcN4P
         sy/yCikSjz58+Qn2S+H8RMaMaE+wTiL3l6TiqNZOqJTzqqWOHvE0sOlSXQVjRrVBni9X
         n3DOGUahmNzOP9HP9KUOVlX/dSWRbuowJIm9lKSrzcgjAnf8lS1O3Dpw7cknlG7+8hUD
         pU5Q==
X-Gm-Message-State: APjAAAVcL13++CsA7DlFExYuH8B0wqiQSD7bSnUVTd9UFpOWVb3xZGt0
        K46ZPhP//qJXg/zmqM18+KkL5w==
X-Google-Smtp-Source: APXvYqxHTtcGCd6guRClzsf2hMpfCceIilSXsOLN3i8u7kfcvvLbI4hev8qwxnnblwm+97LZVBnbdg==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr31113362wrm.293.1577118569579;
        Mon, 23 Dec 2019 08:29:29 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id p26sm19436362wmc.24.2019.12.23.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:29:29 -0800 (PST)
Message-ID: <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
From:   Andrea Vai <andrea.vai@unipv.it>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Ming Lei <ming.lei@redhat.com>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 23 Dec 2019 17:29:27 +0100
In-Reply-To: <20191223162619.GA3282@mit.edu>
References: <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
         <20191210080550.GA5699@ming.t460p> <20191211024137.GB61323@mit.edu>
         <20191211040058.GC6864@ming.t460p> <20191211160745.GA129186@mit.edu>
         <20191211213316.GA14983@ming.t460p>
         <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
         <20191218094830.GB30602@ming.t460p>
         <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
         <20191223130828.GA25948@ming.t460p> <20191223162619.GA3282@mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno lun, 23/12/2019 alle 11.26 -0500, Theodore Y. Ts'o ha
scritto:
> On Mon, Dec 23, 2019 at 09:08:28PM +0800, Ming Lei wrote:
> > 
> > From the above trace:
> > 
> >   b'blk_mq_sched_request_inserted'
> >   b'blk_mq_sched_request_inserted'
> >   b'dd_insert_requests'
> >   b'blk_mq_sched_insert_requests'
> >   b'blk_mq_flush_plug_list'
> >   b'blk_flush_plug_list'
> >   b'io_schedule_prepare'
> >   b'io_schedule'
> >   b'rq_qos_wait'
> >   b'wbt_wait'
> >   b'__rq_qos_throttle'
> >   b'blk_mq_make_request'
> >   b'generic_make_request'
> >   b'submit_bio'
> >   b'ext4_io_submit'
> >   b'ext4_writepages'
> >   b'do_writepages'
> >   b'__filemap_fdatawrite_range'
> >   b'ext4_release_file'
> >   b'__fput'
> >   b'task_work_run'
> >   b'exit_to_usermode_loop'
> >   b'do_syscall_64'
> >   b'entry_SYSCALL_64_after_hwframe'
> >     b'cp' [19863]
> >     4400
> > 
> > So this write is clearly from 'cp' process, and it should be one
> > ext4 fs issue.
> 
> We need a system call trace of the cp process, to understand what
> system call is resulting in fput, (eg., I assume it's close(2) but
> let's be sure), and often it's calling that system call.
> 
> What cp process is it?  Is it from shellutils?  Is it from busybox?
> 
>      		   	      	   		- Ted

I run the cp command from a bash script, or from a bash shell. I don't
know if this answer your question, otherwise feel free to tell me a
way to find the answer to give you.

Thanks,
Andrea

