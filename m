Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E37C13239B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgAGKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 05:32:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39236 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:32:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so38479516lfb.6;
        Tue, 07 Jan 2020 02:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9E2KDCByWOknOsVNn8KPZIFGxXDqcek2mHsdVguQL8I=;
        b=mPPeJz08QIZuOxdWYEG4octLskrR4olS6GscDie896g76J3nXLcgXT1drZ0KeRXb5g
         cBMJ7qryxgFBzYAzULItqVcgklM1CNkrZvLoyI/jrwC65H3dDs9142so4mpCCB5+jGyU
         obzd48dohkiLYgVkB1h54qqebkAVkbTSKHcmj0CSVfWW0XDKb2xM5EWGyFtabPguprKk
         xnGlS3AmAnpdvQZMO7zkui3yzhipHlKF1plqPhlGljViBCJFkqkJZbiqVyMWEAxRHLcx
         kPkpbhPtrNEWzDJwxvmKgTTNA2BXAnGlTDgI+qni9c5Aeh13BX42g6vK4ws7RXD4Q/dV
         UlUQ==
X-Gm-Message-State: APjAAAU7tA24lzN509rI+daWbyAPKnwUTcLzs5izY73i7xU+Wn2WMaTS
        5TYWTOwRfbj6JkNQViuGnFw=
X-Google-Smtp-Source: APXvYqwlm/6jpYNpmjVkNQRL7cF+uIW3YJNyP2AXWNJ3o6yCtii8lNqxdybvu0qoh7/mKSyzX3ktyQ==
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr59480699lfo.23.1578393120629;
        Tue, 07 Jan 2020 02:32:00 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id b17sm30541803ljd.5.2020.01.07.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:31:59 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iom9f-0005G9-Ru; Tue, 07 Jan 2020 11:32:07 +0100
Date:   Tue, 7 Jan 2020 11:32:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brant Merryman <Brant.Merryman@silabs.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: Enables usb generic functions for
 throttle/unthrottle to prevent USB data loss.
Message-ID: <20200107103207.GC30908@localhost>
References: <D6486D05-4E0F-4CDF-B178-C386A9075032@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6486D05-4E0F-4CDF-B178-C386A9075032@silabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:55:04PM +0000, Brant Merryman wrote:
> USB: serial: cp210x: Enables usb generic functions for
>  throttle/unthrottle to prevent USB data loss.

Please resubmit this with a short summary (Subject, < 80 chars) and
separate commit message (body). Try to explain why this is needed a bit
more verbosely.

> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
> ---

Also always include a changelog here (after "---") when you update
patches, and indicate the patch revision in the Subject prefix (e.g.
this should have been "[PATCH v2]".

Since the two patches you sent are related, you should submit them in a
series. Take a look at git-format-patch and git-send-email for one way
of doing that, more details can be found in:

	Documentation/process/submitting-patches.rst

Let's get you up to speed on the process now, so that we don't have to
deal with that bit for your future contributions.

Johan
