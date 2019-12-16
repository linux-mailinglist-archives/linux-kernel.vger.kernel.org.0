Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C332E120744
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfLPNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 08:36:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37381 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfLPNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:36:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so9272370otn.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXDlN8mcTWwRwBjDVORiAMAmoH+nViEUJ1e7bGO4MwE=;
        b=lFPtqu/ZeW7wTcLM/5LZ6ieZy35bxLuO4XYiRwzzumta7qsKsGvz2ODyTTqOnewqUl
         WE8WepFHgovJh4WqGJFJ4wSy8XYP03Zhde42AG/Xl6oKxcLXQ6ylr1Gg7LCeoetXzJGC
         5HeG43QNp2uS86gWQmS89mLz0DPgAT9SYqUZHXN+ltu0X4/Ff0y2NUzVfbRwtO9bP33D
         A/BjQWQ05+LyspLPLsWCDD0Arp3dTNPJucn21XBM++qJCPHOpuz+9WwqoV2TvmmYRvIQ
         9h/9FJzLpLlAL8GO25pFjZ+05gCYkt1/EgEr60dGFx8e6T1W3X0BH+kDg15s00A2HTpf
         S4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXDlN8mcTWwRwBjDVORiAMAmoH+nViEUJ1e7bGO4MwE=;
        b=k77MBkR7ELu2AD61jKxE12fOZO9fQFi28AJQmFF+VdlpgGOJ/EWVyRJBmp2b65h/lH
         x1loolZW8kUm8bchgN67ml5Y8jOnwt3cejd3YTdjwvZMSaoDOUSEgtgwCN/HM39IIucr
         CA8IZU3YAXFWC/EMXKPMxY+Oy5mNO5XncelGLrLk9F3mCeMF4c+IIcjqF55yHHKtAr6f
         SDQmj5uC7gFOHQIoYCJXQ5fj0obMEYqZxYEqj4eRsFEURtu/ueTye0NjBTfPEJpBlOzi
         gAY8AOAJd85/E5IXdjTgmuZ/MPJGkdH63Z0ksGNyPgpHbRDErnrmCtUOTdbyQxq5jtAY
         nlNQ==
X-Gm-Message-State: APjAAAXI6gRYHtLmeu3Y5wuoiRgjwvFmnekHAw3iGlL7KYiY9BdMJw6m
        8a2eDcILJRX32N01Z9T7Dxc=
X-Google-Smtp-Source: APXvYqyAIu+wt/1HJ0EO6Q+lLnCIR9/jIZTbKJrUEeLUIvzbokRDrZVKcO5IlxOs7FZgdhwKyz2d4g==
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr30751038otq.134.1576503367005;
        Mon, 16 Dec 2019 05:36:07 -0800 (PST)
Received: from JosephdeMacBook-Pro.local ([205.204.117.14])
        by smtp.gmail.com with ESMTPSA id w201sm6695390oif.29.2019.12.16.05.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 05:36:06 -0800 (PST)
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: call journal flush to mark
 journal as empty after journal recovery when mount
To:     Likai <li.kai4@h3c.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "chge@linux.alibaba.com" <chge@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <20191212060000.930-1-li.kai4@h3c.com>
 <7cf9e23b-04a1-09a0-77a6-fe31f7a6a1b5@linux.alibaba.com>
 <57197a96b6e145bf8f992f103157cb1f@h3c.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <6e031007-746a-76ec-e542-ca18ab830dc6@gmail.com>
Date:   Mon, 16 Dec 2019 21:36:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <57197a96b6e145bf8f992f103157cb1f@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/16 20:12, Likai wrote:
> On 2019/12/16 18:02, Joseph Qi wrote:
>>
>> On 19/12/12 14:00, Kai Li wrote:
>>> If journal is dirty when mount, it will be replayed but jbd2 sb
>>> log tail cannot be updated to mark a new start because
>>> journal->j_flag has already been set with JBD2_ABORT first
>>> in journal_init_common. When a new transaction is committed, it
>>> will be recored in block 1 first(journal->j_tail is set to 1 in
>>> journal_reset).If emergency restart happens again before journal
>>> super block is updated unfortunately, the new recorded trans will
>>> not be replayed in the next mount.
>>>
>>> The following steps describe this procedure in detail.
>>> 1. mount and touch some files
>>> 2. these transactions are committed to journal area but not checkpointed
>>> 3. emergency restart
>>> 4. mount again and its journals are replayed
>>> 5. journal super block's first s_start is 1, but its s_seq is not updated
>>> 6. touch a new file and its trans is committed but not checkpointed
>>> 7. emergency restart again
>>> 8. mount and journal is dirty, but trans committed in 6 will not be
>>> replayed.
>>>
>>> This exception happens easily when this lun is used by only one node. If it
>>> is used by multi-nodes, other node will replay its journal and its
>>> journal super block will be updated after recovery like what this patch
>>> does.
>>>
>>> ocfs2_recover_node->ocfs2_replay_journal.
>>>
>>> The following jbd2 journal can be generated by touching a new file after
>>> journal is replayed, and seq 15 is the first valid commit, but first seq
>>> is 13 in journal super block.
>>> logdump:
>>> Block 0: Journal Superblock
>>> Seq: 0   Type: 4 (JBD2_SUPERBLOCK_V2)
>>> Blocksize: 4096   Total Blocks: 32768   First Block: 1
>>> First Commit ID: 13   Start Log Blknum: 1
>>> Error: 0
>>> Feature Compat: 0
>>> Feature Incompat: 2 block64
>>> Feature RO compat: 0
>>> Journal UUID: 4ED3822C54294467A4F8E87D2BA4BC36
>>> FS Share Cnt: 1   Dynamic Superblk Blknum: 0
>>> Per Txn Block Limit    Journal: 0    Data: 0
>>>
>>> Block 1: Journal Commit Block
>>> Seq: 14   Type: 2 (JBD2_COMMIT_BLOCK)
>>>
>>> Block 2: Journal Descriptor
>>> Seq: 15   Type: 1 (JBD2_DESCRIPTOR_BLOCK)
>>> No. Blocknum        Flags
>>>  0. 587             none
>>> UUID: 00000000000000000000000000000000
>>>  1. 8257792         JBD2_FLAG_SAME_UUID
>>>  2. 619             JBD2_FLAG_SAME_UUID
>>>  3. 24772864        JBD2_FLAG_SAME_UUID
>>>  4. 8257802         JBD2_FLAG_SAME_UUID
>>>  5. 513             JBD2_FLAG_SAME_UUID JBD2_FLAG_LAST_TAG
>>> ...
>>> Block 7: Inode
>>> Inode: 8257802   Mode: 0640   Generation: 57157641 (0x3682809)
>>> FS Generation: 2839773110 (0xa9437fb6)
>>> CRC32: 00000000   ECC: 0000
>>> Type: Regular   Attr: 0x0   Flags: Valid
>>> Dynamic Features: (0x1) InlineData
>>> User: 0 (root)   Group: 0 (root)   Size: 7
>>> Links: 1   Clusters: 0
>>> ctime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
>>> atime: 0x5de5d870 0x113181a1 -- Tue Dec  3 11:37:20.288457121 2019
>>> mtime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
>>> dtime: 0x0 -- Thu Jan  1 08:00:00 1970
>>> ...
>>> Block 9: Journal Commit Block
>>> Seq: 15   Type: 2 (JBD2_COMMIT_BLOCK)
>>>
>>> The following is jouranl recovery log when recovering the upper jbd2
>>> journal when mount again.
>>> syslog:
>>> [ 2265.648622] ocfs2: File system on device (252,1) was not unmounted cleanly, recovering it.
>>> [ 2265.649695] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 0
>>> [ 2265.650407] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 1
>>> [ 2265.650409] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 2
>>> [ 2265.650410] fs/jbd2/recovery.c:(jbd2_journal_recover, 278): JBD2: recovery, exit status 0, recovered transactions 13 to 13
>>>
>>> Due to first commit seq 13 recorded in journal super is not consistent
>>> with the value recorded in block 1(seq is 14), journal recovery will be
>>> terminated before seq 15 even though it is an unbroken commit, inode
>>> 8257802 is a new file and it will be lost.
>>>
>>> Signed-off-by: Kai Li <li.kai4@h3c.com>
>>> ---
>>>  fs/ocfs2/journal.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
>>> index 1afe57f425a0..5c7a489f47b0 100644
>>> --- a/fs/ocfs2/journal.c
>>> +++ b/fs/ocfs2/journal.c
>>> @@ -1066,6 +1066,15 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
>>>  
>>>  	ocfs2_clear_journal_error(osb->sb, journal->j_journal, osb->slot_num);
>>>  
>>> +	if (replayed) {
>>> +		mlog(ML_NOTICE, "journal recovery complete");
>> I don't think this log is appropriate, or we can change it to something like:
>> "Journal is dirty, wipe it first"?
>>
>> Thanks,
>> Joseph
> This log is not used to interpret journal flush's purpose and calling
> journal flush to make jbd2 super block become normal should be a
> requisite operation internally,
> maybe a mark should be better I think if necessary.
> In addition,  ocfs2 prints a log like 'ocfs2: File system on device (%s)
> was not  unmounted cleanly, recovering it' before,
> and  journal has already been replayed in
> jbd2_journal_load->jbd2_journal_recover,  this log just means that it is
> done here.
> So I don't think it is inappropriate,  could you think abort my proposal
> again?
> 
Not really, just think that this log has no actual meaning.
Or we can simply remove it.

Thanks,
Joseph
