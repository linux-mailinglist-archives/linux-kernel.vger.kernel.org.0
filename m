Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52C014B95B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 15:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgA1Oar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 09:30:47 -0500
Received: from sonic310-14.consmr.mail.bf2.yahoo.com ([74.6.135.124]:35868
        "EHLO sonic310-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387502AbgA1Oan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580221841; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=FA1j/CFZPZETChuHGkHQEZ8Vzp6nm1rF3XUJ4uAvmLHx2i1J5s0TqRQdK7v29+WieBE+fi8qShjTPn68GncLN3H5g8WqthtkTsbyTt+OKs3r+BtUxNXhTuE/qgZ/6YtWd4H3ThzAioRQNlzgw/Vbw3XrzLAhpsMmK8lj93lNQYb1PPiDsLCb4NozSxlN/4pvlbBs7b8QCHjlB3g183fCMu7PK4YWXxQ66mDUiXxQql5YnAPphZUtniM+4ykLnx8qAG8wRzXDxvBkJ+u6+7QM+kEtgKs4EtHriosWUEjxe3qGgYodEEGNILwFoLmbcxkTI0yMTFyFIEUetK5vtHcYKw==
X-YMail-OSG: PZdTfqsVM1l4rm9WePRuixIXFZRPz1Rp3Uu1jfYbV3AfibH24Tv8iutXcDZ.FJ1
 hsNxDEzcab3bsd.5ANuy3p4gjUcz7y17_iJQMSwqKnlNn0PaU6SzpYhOmwbhQSkgkEKpFvQn.K7G
 L0ZpqeGnRz.pbXPQcv5YgtxoDqHOeXr6RXJ7vZbMnE33VIauTzx2rTvyx_2HEvk9bt79NshVdrQy
 .aLBvUmB9rqRUGANFRrun5LhQM2axFz9u5IIJbGlWHfCCrrmTY2yHgZrwuwjcqMnxeaiYrPwR2JO
 JAe7s_6bgop18WTfHMteE9YcnP3G8YE8pDKsHfArL8upO6NbwllClO7AeIdPbBFDlBhhgbLLKSMy
 99E0jIZBVhy4sHDpGcMQkRAZrLy2JreMOCeqx1Uk7vh..jsDPZL6JQDSsQFOG4hwHq3.5gh12vLq
 ICxojbwg6H7jcrJkOHAwdNzl7Wh_RHQVnpVaa5kArNG7abPYUpkSF6tB9ewuoV3HuypSQr0RPANP
 ll4ihx5rh1qfxuWRXwLnypC3vbC368jZiRwCqS7qduUFhabYNGgIVPfvD2aW9y2yY9TlE2zCvqiT
 lpR.Lt2kg_V.MIUXH1yYAFKQmHcB_8HNuUTuRAs6GHvRyDpOaj9Ur8GkSqSgkipJRmRjtiJ8KwZL
 klMXNtfq40Ze_MqtefpH01yz3ehOK_b.4CeTdmZA2EaH0BBQe9ZpXxX4EoRdU7iND62JyIWYRSDI
 KiyB4Ov.6WQXIEf5g7XzKOnT6HmvpfNaaQjo8D0RN_etU.I6F1ooEwDJMgmMFGDGxF1MvjK7XwZJ
 l_8VbnbFartsjJFMHRtrDgMep5F2ryViSqVv1WuK8ZidA6tA37haplLS.gfGWM.6DmqSIqDONybn
 K25HxVZsEfklIc3qZfU6Z0Dtql.X6ymfV_4cQBniMjwge2vYjZ.fGU.8XOh7bpCSJdNdqJWzIW1A
 9OCAuVRapAZkhR9J4bDWxdAjentXxJeAFAXIw5N1d9xcEtH_fxJ53GsPpwall0_RJiUiPkHopC14
 OvLPtQfLCuFh.UZJN2xuDAeDeupX2YZkB1Ck.4cdELt1JDGHOns_4XSbXG_bR48fqxcoS3OHwJ8w
 soRoSzf26Iy8I8AuhlV6btbVgdYBO3aQ8y.tgTom2W4gCtVRQgaY9kYEBa1e7.EvYmsH9pAgu5MQ
 TdyEUuV.VKWHWBDeM1wnEG.xDFEAKY37rg1ldg_YVn82j.N9jjwCKjc0uLCOzpYipmGKHVd6B_6R
 N3o8Kw4x9ggwituA4R3trbx0waaUoMmLq6qNEaose_vDr4jTRbXr5Zlij1BN0UYBDMsRK3zXPSmM
 w0ewQaPoygfc9pO8CNHA2WCjp43iYCyU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 Jan 2020 14:30:41 +0000
Date:   Tue, 28 Jan 2020 14:30:41 +0000 (UTC)
From:   Aisha Gaddafi <gaddafi661@gmail.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <1411325105.265606.1580221841360@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1411325105.265606.1580221841360.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15116 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaddafia504@gmail.com)
