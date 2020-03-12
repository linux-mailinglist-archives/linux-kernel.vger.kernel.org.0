Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC918362B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 17:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCLQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 12:31:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52818 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCLQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:31:04 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id D182A200767C;
        Thu, 12 Mar 2020 09:31:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D182A200767C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584030663;
        bh=OjaD6vj5jDRRnc88DeZb3dxL22aY2mB5SenuU5W0AH8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T1oKFagdtk0+yUEjGk+EeSbt0BRqrPF+TjppnSaSCIZq6gHmgNzQEknovZwS+2trS
         lrRXeniy/m7g0Asyv4MnTr5iv8afQj/mulQobN9l/AXEy3r5FpQ//mx0rYa/ihztaw
         i97tvY9P7a0sVVFitEeD4C8621QkgO9MUfYDRzsY=
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: rtw_mlme: Remove
 unnecessary conditions
To:     Julia Lawall <julia.lawall@inria.fr>,
        Stefano Brivio <sbrivio@redhat.com>
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
References: <20200311135859.5626-1-shreeya.patel23498@gmail.com>
 <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com>
 <20200312113416.23d3db5c@elisabeth>
 <alpine.DEB.2.21.2003121145540.2418@hadrien>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b5daea1c-8172-93b6-0956-b31c3798d373@linux.microsoft.com>
Date:   Thu, 12 Mar 2020 09:31:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003121145540.2418@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/2020 3:49 AM, Julia Lawall wrote:

Thanks for your input Julia and Stefano.

>> That's my general preference as well, but I can't find any point in the
>> "Describe your changes" section of submitting-patches.rst actually
>> defining the order. I wouldn't imply that from the sequence the steps
>> are presented in.
>>
>> In case it's possible to say everything with a single statement as
>> Shreeya did here, though, I guess that becomes rather a linguistic
>> factor, and I personally prefer the concise version here.
> 
> https://kernelnewbies.org/PatchPhilosophy suggests:
> 
> In patch descriptions and in the subject, it is common and preferable to
> use present-tense, imperative language. Write as if you are telling git
> what to do with your patch.

Use of imperative language is the approach I was thinking as well.

thanks,
  -lakshmi
