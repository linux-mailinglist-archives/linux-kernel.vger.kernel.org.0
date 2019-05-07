Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7D162F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEGLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 07:42:33 -0400
Received: from node.akkea.ca ([192.155.83.177]:49682 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfEGLmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:42:33 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id BEBD64E204B; Tue,  7 May 2019 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557229352; bh=C0T2IpdRD2/K4cMjYfhgSOlqn0r5UpwBR7WvL8IiUxg=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=j2B8NPcCR3ORPAgBvJcTecqX0UPlq2iT20JQafpPzEe75dx+wfNMBnhdCp0BQ1Dak
         Urr86UQP9JVCzZhCKYCBuFVGkKLmCnp0slkj5E3jYm0M03vcijnquo6p1hTnVwYqjG
         PK/7pOsoGEeAkoCPz3ppKSpwUXbnOZIlScuoo5/g=
To:     Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] usb: typec: tcpm: Clear the fault status register
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 May 2019 05:42:32 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Fabio Estevam <festevam@gmail.com>, angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck7@gmail.com>
In-Reply-To: <20190506152736.GA29049@roeck-us.net>
References: <20190506140830.25376-1-angus@akkea.ca>
 <20190506140830.25376-4-angus@akkea.ca>
 <CAOMZO5C6XQUWBi39jKeVJg3Jj6auB0mF3h8bWMYZ_prXwgc9Fg@mail.gmail.com>
 <20190506152736.GA29049@roeck-us.net>
Message-ID: <c0345959db38ad5ba1c8f370c31c63cb@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-06 09:27, Guenter Roeck wrote:
> On Mon, May 06, 2019 at 12:11:41PM -0300, Fabio Estevam wrote:
>> Hi Angus,
>> 
>> On Mon, May 6, 2019 at 11:10 AM Angus Ainslie (Purism) 
>> <angus@akkea.ca> wrote:
>> >
>> > If the fault status register doesn't get cleared then
>> > the ptn5110 interrupt gets stuck on. As the fault register gets
>> > set everytime the ptn5110 powers on the interrupt is always stuck.
>> >
>> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> 
>> Since this is a bug fix, I would suggest adding a Fixes tag and Cc
>> stable if appropriate.
>> 
>> I would also put this patch as the first one in the series, so that it
>> can be easily applied to older stable trees.
> 
> Unfortunately there is an added tcpm_log() ... and I am opposed to 
> exporting
> that.
> 

Ok I'll fix them both up for v2.

> Guenter

