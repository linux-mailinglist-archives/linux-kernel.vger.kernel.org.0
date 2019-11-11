Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7DF74C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 14:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKKN13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 08:27:29 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40734 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKKN13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:27:29 -0500
Received: by mail-qt1-f170.google.com with SMTP id o49so15623604qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vzVvMTX2LFv9S1B1exKBhiHOJQP/YcVxVxCKJ0piDj4=;
        b=WzrvYiMQ8gZNIHiDTEN7JpWKgxp+gKJEVubolXb9QKspoTw5cbOxKpK6Wo339j8k4E
         1if/iSjrxQaOimdHRtwFTGRMyz029WHGzHlytiH8JX93gbkk7SqPGoN5tVcQ5tJoBXUZ
         xa4fhcCcXUBU63Bx+l1GRe18gRIOl1d6YkCqvOzu7Wa46Lg484AQz/kGvXL7i6DjwIbH
         9rRYh6lfO3L7676LfOd0sg06neB5H7SQXJOFgUL+0NztCa+YfFMbVkYNvQ80wBlD5eD2
         EhTp2mtZWGlXBs4y0fW73c+ZoyevYhQ71EN1CZe7SZliDcZXRkjUtlW/4bvHcaRGYi9V
         Jy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vzVvMTX2LFv9S1B1exKBhiHOJQP/YcVxVxCKJ0piDj4=;
        b=dOXgMXNSMfjtpPzVxN3OBkk2JuVJ8cuqYdohDjkGNh8pSKMeEoQFZkTRHA630ks8zG
         Mr1HsHP/n/LRTIk+Ua8uLD8JpBz0hqER4ntSBzdhzJ61ny8AZ2qAaOUHvfpskdGcS8TL
         uwGWideEb1T4Ay0GxDBIjKStlOGxpIldyzH3WRDQK7oInTu2oSDRPMic3wL2DKgCY3rS
         Hb2kCwmnC8mNe6f4ARwCKjioynUXCCInA2pVKQdTN5Uec415lgdLdXdeuR9QXbwfq/EC
         /1vqwvXovs0dkYy5acgIDfIhSnqebVc8nDhAJ75NDGJSQMeO8cRVS43nH92kaR7tnpum
         DhHg==
X-Gm-Message-State: APjAAAV23VAYrjNNuZxll5d9Eaep39u3RECnVZ07+gcUMryQg4/cMQSd
        wwPXa03olnwZysFMZXXeoIFrAkI3dkPsLjyy7AcQgw==
X-Google-Smtp-Source: APXvYqyqP4a+Cm1qniSn+zMVmWEo3DkyXOj+WGA0fpNz+Ps5uCLUiezR7sALC0kVqPIkrX/dnB2zk3AmXTwz7Mf0OuU=
X-Received: by 2002:ac8:1859:: with SMTP id n25mr24772767qtk.333.1573478847837;
 Mon, 11 Nov 2019 05:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20190826151640.5036-3-flameeyes@flameeyes.com>
 <20191103160030.GO1384@kitsune.suse.cz> <CAHcsgXRtWAt0mEQoW2rn1v6yYZ8ZKygKVetk4mnm_o+pwgwcVw@mail.gmail.com>
 <20191111131817.GA2770@kitsune.suse.cz>
In-Reply-To: <20191111131817.GA2770@kitsune.suse.cz>
From:   =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>
Date:   Mon, 11 Nov 2019 13:27:17 +0000
Message-ID: <CAHcsgXTXcT4uoBH2NfZ-A2sqvEYX5a3Rg-GpA+ZB0JnCTWcVjw@mail.gmail.com>
Subject: Re: cdrom: make debug logging rely on pr_debug and debugfs only.
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 1:18 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
> Maybe you can drop this part entirely to not get conflicts.

That's awesome, thanks! I just managed to get something that looks
right but I'm not sure how right it is, I'll skip this part in the
series and re-send the rest!
