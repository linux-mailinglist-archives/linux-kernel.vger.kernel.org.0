Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5B51203C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLPLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:24:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49778 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLPLYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:24:00 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 83BD7200AC3;
        Mon, 16 Dec 2019 11:23:58 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D6FA420608; Mon, 16 Dec 2019 11:18:34 +0100 (CET)
Date:   Mon, 16 Dec 2019 11:18:34 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v3 01/10] PCMCIA/i82092: use dev_<level> instead of printk
Message-ID: <20191216101834.GA159459@light.dominikbrodowski.net>
References: <20191213135311.9111-1-simon.geis@fau.de>
 <20191213135311.9111-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213135311.9111-2-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:53:04PM +0100, Simon Geis wrote:
> Improve the log output by using the
> device-aware dev_err()/dev_info() functions. While at it, update one
> remaining printk(KERN_ERR ...) call to the preferred pr_err() call
> and delete commented out debugging lines.
> 
> Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Simon Geis <simon.geis@fau.de>

Applied, minus the one hunk which didn't serve any purpose:

> @@ -417,7 +421,9 @@ static int i82092aa_init(struct pcmcia_socket *sock)
>                                                                                                                                                                                                                                                
>  static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
>  {
> -	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
> +	struct socket_info *sock_info = container_of(socket, struct socket_info,
> +						     socket);
> +	unsigned int sock = sock_info->number;
>  	unsigned int status;
>  	
>  	enter("i82092aa_get_status");

Thanks,
	Dominik
