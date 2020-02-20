Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D43166A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 23:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgBTW3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 17:29:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44020 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBTW3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:29:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id g21so4108778qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JBTeYjQ4OSxmuiL2ZqLwcDcFNG9wOe01nNDIgFt4X8=;
        b=Jcjpzc7EBrfLq2tuPgjvbEzIeeVuOA4sAvis/RvWvv/Brx1gksKftAVO1KFKzvpy8z
         XCC6EJY3G5JHV132lV1wCm7LN1f/rfmt3+CH4EjSPI+zAqxp95FAfYm78JB7z2zLcnjP
         gP0g8gVAg4LUlFpnBhuUnZWh5uuqRb+EMzAj+dK9o7cZx7I9EZ62x0+G6D1oWAmsNYoK
         NqoSZlefuuuXNQLbRqB0WCf10W3Pj/SPDuDukffuQl43IFMudS1AXuu3aDEjB+QnU1vs
         76oVvCXEpK9RHZXVjNzKRAL5u+rHJ1RYSrZfcICqlgQS4cAdEgk4uj27yWO3v8QVTcFj
         fPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JBTeYjQ4OSxmuiL2ZqLwcDcFNG9wOe01nNDIgFt4X8=;
        b=aj1Qjc0ik2RyNXQqz5wuy6eLRMOBtcmX62Q9imCzuByQzMwO9tgnO3acArxOcyl3+B
         LjjC0rWfjCuvXxHBUokHCwWN/3fx+KxKJg0eDjP2LqqRybuUTbgmj8VNmPovZOlZlW3v
         1MoJFUrJldCM38DC2nA3Ppy4TYTT6813DIzZ7y5VmXBYgJzpJ83Pe8XLzbVZmX865u6Y
         vf5TBihL7tvNFQ4WL/zlTqIn1DGEBPSlQatmmf70UDDSQi2XjX6XEOvtfXW0+fr4UNSr
         XErkFSMAChzyOwLSSbMCpRhavNmPwfn65GZ6z7QJQIEBt6e/VxnG+2o9rCVgWFKbgkjl
         X/2g==
X-Gm-Message-State: APjAAAWWfYFR/ha9qoyzAVCXJE3hkGbDBdvnaDBIUkozrQyn9qEDTwu/
        A7oftqfhzQbTFpdLvHpqaeI8OY6au+OIP/oLnK6oZ2sc
X-Google-Smtp-Source: APXvYqwoWrH7/If0ame9SZaVwZx3aYtuG3KUWXrbZCSZ/1HYk27oz6ttjY7BHfQHj8CWFY3vOIj4TG728lbd0zUqX2I=
X-Received: by 2002:ac8:381a:: with SMTP id q26mr29289352qtb.381.1582237783761;
 Thu, 20 Feb 2020 14:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20200216161836.1976-1-Jason@zx2c4.com> <20200216182319.GA54139@kroah.com>
 <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
In-Reply-To: <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Thu, 20 Feb 2020 14:29:32 -0800
Message-ID: <CA+8MBbKyRhipHsxb0nvV11Bvv8ypQ_gq5JR8ihfuG6JfBTnxZw@mail.gmail.com>
Subject: Re: [PATCH] random: always use batched entropy for get_random_u{32,64}
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, "Ted Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also ... what's the deal with a spin_lock on a per-cpu structure?

        batch = raw_cpu_ptr(&batched_entropy_u64);
        spin_lock_irqsave(&batch->batch_lock, flags);
        if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
                extract_crng((u8 *)batch->entropy_u64);
                batch->position = 0;
        }
        ret = batch->entropy_u64[batch->position++];
        spin_unlock_irqrestore(&batch->batch_lock, flags);

Could we just disable interrupts and pre-emption around the entropy extraction?

-Tony
