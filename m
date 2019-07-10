Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636CA6313E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfGIGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 02:52:37 -0400
Received: from first.geanix.com ([116.203.34.67]:46616 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfGIGwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:52:37 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id BCEB9A74D;
        Tue,  9 Jul 2019 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562655066; bh=RfeiGUEKWH7qyJygRhO8clCB6nnYi59qk/T4EI2NSKA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vmkmm7eKlyoVJek7jGJmJDi6yGPdV0siQDLLGnRJxd7fZEinxlWPv4VfkdxfHD0ix
         J5ENPe/6AHNJlxW/RtiMlMhEujYj4n612N1foZk2NAxRPlPMzQyqqeaQ3aRF7q4RE1
         EfDi9ofucO2OUj5kR6PuMdQ8xVFVZqPjRZjUGt0s9VSQSSSuTuLDFRBtc/S+Mdu3eu
         PUcDbDTBTifDKTuSV9mWnrIBu0d5YkGfh9MSB8h5GeFAjdRReaurwwkbnk3Q9mElrf
         EnoYoK6KEHMqnMvm1TBoZSTcSSZmVMx0d45Ke2NdtIGOTpii+tkMqmLWAt4TO+FFsK
         bIqW71YI53CLw==
Subject: Re: [PATCHv2 4/4] tty: n_gsm: add ioctl to map serial device to
 mux'ed tty
To:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Esben Haabendal <esben@geanix.com>,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>
References: <20190709064633.45411-1-martin@geanix.com>
 <20190709064633.45411-4-martin@geanix.com>
 <97618a78-36e7-f071-47e2-beadbd505cb6@suse.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <764ab112-0e0d-fa10-607a-6ffb1f53297d@geanix.com>
Date:   Tue, 9 Jul 2019 08:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <97618a78-36e7-f071-47e2-beadbd505cb6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2019 08.49, Jiri Slaby wrote:
> On 09. 07. 19, 8:46, Martin Hundebøll  wrote:
>> @@ -2623,6 +2624,9 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
>>   		if (copy_from_user(&c, (void *)arg, sizeof(c)))
>>   			return -EFAULT;
>>   		return gsm_config(gsm, &c);
>> +	case GSMIOC_GETBASE:
>> +		base = mux_num_to_base(gsm);
>> +		return put_user(base, (int __user *)arg);
> I am not sure, but do you need the local variable at all?

No, I kept it around just to avoid too many parenthesis in the 
put_user() call.

Your call.

// Martin

